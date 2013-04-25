# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise32"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  # config.vm.network :hostonly, "192.168.33.10"
  config.vm.host_name = "rbx-vagrant"

  # Assign this VM to a bridged network, allowing you to connect directly to a
  # network using the host's network device. This makes the VM appear as another
  # physical device on your network.
  # config.vm.network :bridged

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  # config.vm.forward_port 80, 8080
  config.vm.forward_port 3306, 3336

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"
  config.vm.customize ["modifyvm", :id, "--memory", 2048]
  config.vm.customize ["modifyvm", :id, "--vram", 32]


  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding 
  # some recipes and/or roles.
  #
  # Be sure to run librarian-chef install first

  config.vm.provision :chef_solo do |chef|
    chef.log_level = :debug
    chef.json = {
		"mysql" => {
			"server_root_password" => "root",
      "server_repl_password" => "root",
      "server_debian_password" => "root",
			"bind_address" => "0.0.0.0",
			"port" => "3306",
			"tunable" => {
				"lower_case_table_names" => "1"
			}
		},
		"maven" => {
		  "version" => "3", 
		  "2" => {
		   "url" => "http://apache.osuosl.org/maven/maven-2/2.2.1/binaries/apache-maven-2.2.1-bin.tar.gz"
		  },
		  "3" => {
		    "url" => "http://apache.osuosl.org/maven/maven-3/3.0.5/binaries/apache-maven-3.0.5-bin.tar.gz"
		  }
		}
    }
    chef.cookbooks_path = ["cookbooks"]
    chef.add_recipe "ark"
    chef.add_recipe "zsh"
    chef.add_recipe "apt"
    chef.add_recipe "java::openjdk"
    chef.add_recipe "groovy"    
    chef.add_recipe "subversion"
    chef.add_recipe "git"
    chef.add_recipe "maven"
    chef.add_recipe "tomcat"  
    chef.add_recipe "mysql::server"
    chef.add_recipe "rice"
    chef.add_recipe "rice::spring_tool_suite"
    chef.add_recipe "rice::intellij_ultimate"
    chef.add_recipe "rice::desktop"
    chef.add_recipe "rice::rtools"
    chef.add_recipe "rice::mysql-workbench" 
    chef.add_recipe "rice::kfs"    
  end
end
