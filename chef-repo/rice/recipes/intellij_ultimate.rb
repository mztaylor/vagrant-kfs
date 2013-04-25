#
# Cookbook Name:: rice
# Recipe:: intellij_ultimate
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

## intellij

cookbook_file "/usr/share/applications/intellij_iu.desktop" do
  source "ubuntu.intellij.desktop"
  owner node[:rice][:user]
  backup false
  mode "0777"

end

intellij_version = "11.1.4"
"http://download.jetbrains.com/idea/ideaIU-#{intellij_version}.tar.gz"
intellij_mirror_site = "http://download.jetbrains.com/idea/ideaIU-#{intellij_version}.tar.gz"
intellij_file = "ideaIU-#{intellij_version}.tar.gz"
script "install_intellij" do
  interpreter "bash"
  user "root"       
  cwd "/tmp/"
  code <<-EOH
  rm -rf /opt/intellij
  mkdir /opt/intellij
  cd /opt/intellij
  wget #{intellij_mirror_site}
  tar -zxvf #{intellij_file}
  find . -maxdepth 1 -name "idea-IU*" -type d | head -1 | xargs -i sudo ln -s {} idea-IU
  rm -rf ideaIU-#{intellij_version}.tar.gz
  EOH
  only_if do ! File.exists?("/opt/intellij/idea-IU/bin/idea.sh") end
end
