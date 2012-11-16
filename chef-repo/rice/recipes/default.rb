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

ENV['MAVEN_OPTS'] = " -Xmx1g -XX:MaxPermSize=256m "
ENV['HOME'] = "/home/vagrant/"
bash "impex_rice_database" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    echo cd #{node[:rice][:src_dir]}/rice/db/impex/master
    cd #{node[:rice][:src_dir]}/rice/db/impex/master
    mvn -Pdb,mysql clean install -Dimpex.dba.password=root
  EOH
  action :nothing
end

bash "compile_rice_source" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    cd #{node[:rice][:src_dir]}/rice
    mvn -Dmaven.test.skip=true package
  EOH
  action :nothing
end

subversion "rice_source" do
  repository "https://svn.kuali.org/repos/rice/trunk/"
  revision "HEAD"
  destination "/opt/src/rice"
  action :sync
  notifies resources(:bash => "impex_rice_database"), resources(:bash => "compile_rice_source")
end

cookbook_file "#{node[:rice][:src_dir]}/rice/pom.xml.patch" do
  source "rice-pom.xml.patch" # this is the value that would be inferred from the path parameter
  owner node[:rice][:user]
  backup false
  mode "0777"
end

bash "start_rice_sampleapp" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    cd #{node[:rice][:src_dir]}/rice
    patch pom.xml > pom.xml.patch
    cd #{node[:rice][:src_dir]}/rice/sampleapp
    mvn -Dalt.config.location=#{node[:rice][:home_dir]}/sample-app-config.xml -Dmaven.test.skip=true tomcat:run-war -Dojdbc14.jar.location=""
  EOH
end



