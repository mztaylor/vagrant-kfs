#
# Cookbook Name:: rice
# Recipe:: default
#
# Copyright 2012, Example Com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
package "build-essential" do
  action :install
end

user node[:rice][:user] do
  action :create
  system true
  shell "/bin/false"
end

directory "/home/#{node[:rice][:user]}" do
  owner node[:rice][:user]
  mode "0777"
  action :create
  recursive true
end

directory node[:rice][:config_dir] do
  owner node[:rice][:user]
  mode "0777"
  action :create
  recursive true
end

directory node[:rice][:src_dir] do
  owner node[:rice][:user]
  mode "0777"
  action :create
  recursive true
end


directory node[:rice][:log_dir] do
  owner node[:rice][:user]
  mode "0777"
  action :create
  recursive true
end

template "#{node[:rice][:config_dir]}/sample-app-config.xml" do 
  source "sample-app-config.xml.erb"
  mode "0777"
  owner node[:rice][:user]
end

bash "symlink_java_home" do
  cwd Chef::Config[:file_cache_path]
  user "root"
  code <<-EOH
    cd /usr/lib/jvm
    ln -fs java-6-openjdk-i386 default-java
  EOH
  action :run
end


ENV['MAVEN_OPTS'] = " -Xmx1g -XX:MaxPermSize=256m "
bash "impex_rice_database" do
  cwd Chef::Config[:file_cache_path]
  user node[:rice][:user]
  code <<-EOH
    echo cd #{node[:rice][:src_dir]}/rice/db/impex/master
    cd #{node[:rice][:src_dir]}/rice/db/impex/master
    mvn -Pdb,mysql clean install -Dimpex.dba.password=root
  EOH
  action :nothing
end

bash "compile_rice_source" do
  cwd Chef::Config[:file_cache_path]
  user node[:rice][:user]
  code <<-EOH
    cd #{node[:rice][:src_dir]}/rice
    mvn -Dmaven.test.skip=true package
  EOH
  action :nothing
end

bash "install_ojdbc14_jar" do
  cwd Chef::Config[:file_cache_path]
  user node[:rice][:user]
  code <<-EOH
    cd /tmp/
    mvn install:install-file -DgroupId=com.oracle -DartifactId=ojdbc14  -Dversion=10.2.0.3.0 -Dpackaging=jar -Dfile=ojdbc14.jar -DgeneratePom=true
  EOH
  action :nothing
end

cookbook_file "/tmp/ojdbc14.jar" do
  source "ojdbc14.jar"
  owner node[:rice][:user]
  backup false
  mode "0777"
  action :create_if_missing
  notifies :run, resources(:bash => "install_ojdbc14_jar"), :immediately
end

subversion "rice_source" do
  repository "https://svn.kuali.org/repos/rice/trunk/"
  revision "HEAD"
  destination "/opt/src/rice"
  user node[:rice][:user]  
  action :sync
  notifies :run, [resources(:bash => "impex_rice_database"), resources(:bash => "compile_rice_source")], :delayed
end


bash "update_source_access" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    chmod -R 777 /opt/src/rice
  EOH
end


bash "start_rice_sampleapp" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    cd #{node[:rice][:src_dir]}/rice
    patch pom.xml > pom.xml.patch
    cd #{node[:rice][:src_dir]}/rice/sampleapp
    mvn -Dalt.config.location=#{node[:rice][:home_dir]}/sample-app-config.xml -Dmaven.test.skip=true tomcat:run-war -Dojdbc14.jar.location=""
  EOH
  action :nothing
end



