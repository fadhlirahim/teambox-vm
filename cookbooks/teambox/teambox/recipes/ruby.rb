#e = execute "source system profile" do
  #user node[:unix_user]
  #command "source /etc/profile"
  #action :nothing
#end

bash "set ruby enterpise as default ruby" do
  user "root"
  code <<-EOH
  echo "PATH=#{node["ruby_enterprise"]["install_path"]}/bin:$PATH" >> /etc/profile
  EOH
  not_if "grep #{node["ruby_enterprise"]["install_path"]} /etc/profile"
  #notifies :run, resources("execute[source system profile]"), :immediately
end

#e.run_action(:run)
