#
# Cookbook Name:: rice-developer-tools
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

# install the necessary tools based on the environment 

directory "/opt/src/kfs" do
  owner node[:rice][:user]
  mode "0777"
  action :create
  recursive true
end

bash "compile_kfs_source" do
  cwd Chef::Config[:file_cache_path]
  user node[:rice][:user]
  code <<-EOH
    cd /opt/src/kfs
    ant dist-local
    ant make-source
  EOH
  action :nothing
end

subversion "kfs_source" do
  repository "https://svn.kuali.org/repos/kfs/trunk/"
  revision "HEAD"
  destination "/opt/src/kfs"
  user node[:rice][:user]  
  action :sync
end

bash "update_kfs_source_access" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    chmod -R 777 /opt/src/kfs
  EOH
end




