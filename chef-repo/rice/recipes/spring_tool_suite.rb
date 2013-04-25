#
# Cookbook Name:: rice
# Recipe:: spring_tool_suite
#
# Copyright 2013
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

cookbook_file "/usr/share/applications/sts.desktop" do
  source "ubuntu.sts.desktop"
  owner node[:rice][:user]
  backup false
  mode "0777"
  action :create_if_missing  
end

sts_download_site = "http://download.springsource.com/release/STS/2.3.2/dist/e3.5/springsource-tool-suite-2.3.2.RELEASE-e3.5.2-linux-gtk.tar.gz"
sts_file = "springsource-tool-suite-2.3.2.RELEASE-e3.5.2-linux-gtk.tar.gz"
script "install_sts" do
  interpreter "bash"
  user "root"
  cwd "/tmp/"
  code <<-EOH
  rm -rf /opt/springsource
  wget #{sts_download_site}
  tar -zxvf #{sts_file}
  cp -r springsource /opt
  cd /usr/local/bin
  ln -fs /opt/springsource/sts-3.2.0.RELEASE/STS
  EOH
  only_if do ! File.exists?("/opt/springsource/sts-3.2.0.RELEASE/STS") end
end
