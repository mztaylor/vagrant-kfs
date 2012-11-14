default[:rice][:home_dir]       = "/home/vagrant"
default[:rice][:config_dir]  = "#{node[:rice][:home_dir]}/kuali/main/dev"
default[:rice][:src_dir]  = "/opt/src"
default[:rice][:log_dir]   = "/var/log/rice"
# one of: debug, verbose, notice, warning
default[:rice][:loglevel]  = "notice"
default[:rice][:user]      = "rice"
default[:rice][:port]      = 8080
default[:rice][:bind]      = "127.0.0.1"

## rice config parameters
default[:kuali][:rice][:configuration][:datasource][:ojb_platform] = "MySQL"
default[:kuali][:rice][:configuration][:datasource][:platform] = "org.kuali.rice.core.framework.persistence.platform.MySQLDatabasePlatform"
default[:kuali][:rice][:configuration][:datasource][:driver_name] = "com.mysql.jdbc.Driver"
default[:kuali][:rice][:configuration][:datasource][:username] = "RICE"
default[:kuali][:rice][:configuration][:datasource][:password] = "RICE"
default[:kuali][:rice][:configuration][:datasource][:url] = "jdbc:mysql://localhost:3306/rice"
default[:kuali][:rice][:configuration][:config][:location] = []
