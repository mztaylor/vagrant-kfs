#
# Cookbook Name:: rice
# Recipe:: localtunnel
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

# EXPERIMENTAL - thought it be helpful to have a way to sharing the vm server instance with other users
# can run the software calling localtunnel -k ~/.ssh/id_rsa.pub 8080
# will require keytool generated public key first along with ruby and rubygems
# more information can be found at http://progrium.com/localtunnel/

script "install_localtunnel" do
  interpreter "bash"
  user "root"
  cwd "/tmp/"
  code <<-EOH
  gem install localtunnel
  EOH
end