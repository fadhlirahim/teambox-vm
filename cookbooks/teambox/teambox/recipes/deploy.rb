template "#{node[:nginx][:dir]}/sites-available/default" do
  source "teambox.nginx.conf.erb"
  owner node[:unix_user]
  group node[:unix_user]
  mode 0644
  notifies :restart, resources(:service => "nginx")
end

directory "/data/" do
  owner node[:unix_user]
  group node[:unix_user]
  mode "0777"
  action :create
end

directory "/data/teambox" do
  owner node[:unix_user]
  group node[:unix_user]
  mode "0777"
  action :create
end

directory "/data/teambox/shared" do
  owner node[:unix_user]
  group node[:unix_user]
  mode "0777"
  action :create
end

directory "/data/teambox/shared/config" do
  owner node[:unix_user]
  group node[:unix_user]
  mode "0777"
  action :create
end

directory "/data/teambox/shared/log" do
  owner node[:unix_user]
  group node[:unix_user]
  mode "0777"
  action :create
end

directory "/data/teambox/shared/pids" do
  owner node[:unix_user]
  group node[:unix_user]
  mode "0777"
  action :create
end

directory "/data/teambox/shared/assets" do
  owner node[:unix_user]
  group node[:unix_user]
  mode "0777"
  action :create
end

template "/data/teambox/shared/config/database.yml" do
  source "database.yml.erb"
  owner node[:unix_user]
  group node[:unix_user]
  mode 0644
end


ruby_bin = node["ruby_enterprise"]["install_path"] << '/bin'

deploy "/data/teambox" do
  user node[:unix_user]
  repo "git://github.com/teambox/teambox.git"
  environment "RAILS_ENV" => node["environment"]["framework_env"]
  branch "master"
  revision "HEAD"
  action :deploy
  migration_command "#{ruby_bin}/bundle exec #{ruby_bin}/rake db:create db:schema:load"
  migrate true
  restart_command "touch tmp/restart.txt"
  create_dirs_before_symlink  ["tmp"]
 
  # If your app has extra files in the shared folder, specify them here
  symlinks  "system" => "public/system", 
            "pids" => "tmp/pids", 
            "log" => "log",
            "assets" => "assets",
            "config/thinkingsphinx" => "config/thinkingsphinx"

  before_migrate do
    run "cd #{release_path} && #{ruby_bin}/bundle install"
  end

  before_restart do
    template "/data/teambox/current/config/teambox.local.yml" do
      source "teambox.local.yml.erb"
      owner node[:unix_user]
      group node[:unix_user]
      mode 0644
    end
  end

  after_restart do
    app_name = "Teambox2"
    rails_env = node["environment"]["framework_env"]

    # update crontab
    run "cd #{release_path} && #{ruby_bin}/bundle exec #{ruby_bin}/whenever --update-crontab --set environment=#{rails_env} -i #{app_name}"

    # rebuild search index and restart sphinx
    run "cd #{release_path} && #{ruby_bin}/bundle exec #{ruby_bin}/rake thinking_sphinx:index RAILS_ENV=#{rails_env}"

    #sudo "monit -g sphinx_#{app_name} restart"
  end

  before_symlink do
    rails_env = node["environment"]["framework_env"]
    run "cd #{release_path} && #{ruby_bin}/bundle exec #{ruby_bin}/rails runner 'Sprocket.configurations.each { |c| Sprocket.new(c).install_script }' RAILS_ENV=#{rails_env}"
  end
end

logrotate_app "teambox" do
  paths "/data/teambox/current/log/*.log"
  rotate 5
end

nginx_site "default" do
  enable true
end

bash "kill all nginx processes" do
  user "root"
  code <<-EOH
  killall -s QUIT nginx -v
  EOH
end

