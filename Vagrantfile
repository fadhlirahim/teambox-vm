# vim: set filetype=ruby :
Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "base"

  config.vm.customize do |vm|
    vm.name = "Teambox VM"
    vm.memory_size = 512
  end

  # Mounts the app at /app instead of the default /vagrant
  #config.vm.share_folder("v-root", "/app", ".")

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # Ubuntu 10.04 (32 bit)
  config.vm.box_url = "http://files.vagrantup.com/lucid32.box"

  # Boot with a GUI so you can see the screen. (Default is headless)
  #config.vm.boot_mode = :gui

  # Assign this VM to a host only network IP, allowing you to access it
  # via the IP.
  config.vm.network "33.33.33.10"

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  config.vm.forward_port "http", 80, 8080

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"

  # Enable provisioning with chef solo, specifying a cookbooks path (relative
  # to this Vagrantfile), and adding some recipes and/or roles.
  #
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks/teambox"]
    chef.log_level = :debug

    chef.add_recipe("teambox")

    chef.json.merge!({
      :unix_user => 'vagrant',
      :environment => {
        :framework_env => "production"
      },
      :ruby_enterprise => {
        :version      => '1.8.7-2011.03',
        :url          => "http://rubyenterpriseedition.googlecode.com/files/ruby-enterprise-1.8.7-2011.03"
      },
      :nginx => {
        :version => "0.8.54",
        :install_path => "/opt/nginx-0.8.54",
        :configure_flags => [
          "--prefix=/opt/nginx-0.8.54",
          "--conf-path=/etc/nginx/nginx.conf",
          "--with-http_ssl_module",
          "--with-http_gzip_static_module"
        ],
        :gzip => "on",
        :gzip_http_version => "1.0",
        :gzip_comp_level => "2",
        :gzip_proxied => "any",
        :gzip_types => [
          "text/plain",
          "text/html",
          "text/css",
          "application/x-javascript",
          "text/xml",
          "application/xml",
          "application/xml+rss",
          "text/javascript"
        ],
        :keepalive => "on",
        :keepalive_timeout => 65,
        :worker_connections => 2048,
        :server_names_hash_bucket_size => 64
      },
      :passenger_enterprise => {
        :version => "3.0.5"
      },
      :sphinx => {
        :version => '0.9.9',
        :url => "http://www.sphinxsearch.com/downloads/sphinx-0.9.9.tar.gz",
        :stemmer_url => "http://snowball.tartarus.org/dist/libstemmer_c.tgz",
        :use_stemmer => false,
        :configure_flags => ["--with-mysql", "--without-stemmer"]
      },
      :mysql => {
        :server_root_password   => ENV['MYSQL_ROOT_PASSWD'] || 'papapa',
        :server_repl_password   => ENV['MYSQL_REPL_PASSWD'] || 'papapa',
        :server_debian_password => ENV['MYSQL_DEBIAN_PASSWD'] || 'papapa',
        :bind_address => '127.0.0.1',
        :datadir => '/var/lib/mysql',
        :tunable => {
          :key_buffer => '250M',
          :max_connections => '800',
          :wait_timeout => '180',
          :net_write_timeout => '30',
          :back_log => '128',
          :table_cache => '128',
          :max_heap_table_size => '32M'
        }
      },
      :memcached => {
        :memory => 64,
        :port => 11211,
        :user => "nobody"
      }
    })
  end
end

