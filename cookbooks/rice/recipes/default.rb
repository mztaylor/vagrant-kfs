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
  mode "0755"
  action :create
  recursive true
end

directory node[:rice][:src_dir] do
  owner node[:rice][:user]
  mode "0755"
  action :create
  recursive true
end

directory node[:rice][:log_dir] do
  mode 0755
  owner node[:rice][:user]
  action :create
  recursive true
end

subversion "rice" do
  repository "https://svn.kuali.org/repos/rice/trunk/"
  revision "HEAD"
  destination "/opt/src/rice"
  action :sync
end


bash "compile_rice_source" do
  code <<-EOH
  cd /usr/lib/jvm
  EOH
  creates "/opt/src/rice"
end


service "rice" do
  provider Chef::Provider::Service::Upstart
  subscribes :restart, resources(:bash => "compile_rice_source")
  supports :restart => true, :start => true, :stop => true
end

service "rice" do
  action [:enable, :start]
end
