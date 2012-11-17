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

cookbook_file "/usr/share/applications/eclipse.desktop" do
  source "ubuntu.eclipse.desktop"
  owner node[:rice][:user]
  backup false
  mode "0777"
  action :create_if_missing  
end

eclipse_mirror_site = "http://mirror.cc.vt.edu/pub/eclipse/technology/epp/downloads"
eclipse_file = "eclipse-jee-juno-SR1-linux-gtk.tar.gz"
script "install_eclipse" do
  interpreter "bash"
  user "root"
  cwd "/tmp/"
  code <<-EOH
  rm -rf /opt/eclipse
  wget #{eclipse_mirror_site}/release/juno/SR1/#{eclipse_file}
  tar -zxvf #{eclipse_file}
  cp -r eclipse /opt
  cd /usr/local/bin
  ln -fs /opt/eclipse/eclipse
  EOH
  only_if do ! File.exists?("/opt/eclipse/eclipse") end
end
