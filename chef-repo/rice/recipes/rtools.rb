directory "/opt/src/" do
  owner node[:rice][:user]
  mode "0777"
  action :create
  recursive true
end

git "/opt/src/rtools" do
  repository "https://github.com/eghm/rtools.git"
  reference "master"
  user node[:rice][:user]
  action :sync
end