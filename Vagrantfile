# vim: set filetype=ruby :
Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "lucid32"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # config.vm.box_url = "http://domain.com/path/to/above.box"

  # Boot with a GUI so you can see the screen. (Default is headless)
  config.vm.boot_mode = :gui

  # Assign this VM to a host only network IP, allowing you to access it
  # via the IP.
  # config.vm.network "33.33.33.10"

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  # config.vm.forward_port "http", 80, 8080

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"

  # Enable provisioning with chef solo, specifying a cookbooks path (relative
  # to this Vagrantfile), and adding some recipes and/or roles.
  #
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe("teambox")

    chef.json.merge!({
      :mysql => {
        :server_root_password   => ENV['MYSQL_ROOT_PASSWD'] || 'papapa',
        :server_repl_password   => ENV['MYSQL_REPL_PASSWD'] || 'papapa',
        :server_debian_password => ENV['MYSQL_DEBIAN_PASSWD'] || 'papapa',
        :bind_address => '127.0.0.1',
        :datadir = '/var/lib/mysql',
        :tunable => {
          :key_buffer => '250M',
          :max_connections => '800',
          :wait_timeout => '180',
          :net_write_timeout => '30',
          :back_log => '128',
          :table_cache => '128',
          :max_heap_table_size => '32M'
        }
      }
    })
  end

end

