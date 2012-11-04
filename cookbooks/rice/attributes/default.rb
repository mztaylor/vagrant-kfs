default[:rice][:base_dir]       = "/home/vagrant/"
default[:rice][:config_dir]  = "${node[:rice][:rice_dir]}/kuali/main/dev"
default[:rice][:src_dir]  = "/opt/src"
default[:rice][:log_dir]   = "/var/log/rice"
# one of: debug, verbose, notice, warning
default[:rice][:loglevel]  = "notice"
default[:rice][:user]      = "rice"
default[:rice][:port]      = 8080
default[:rice][:bind]      = "127.0.0.1"
