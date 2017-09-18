#
# Author:: Rich Schumacher (<rich@curalate.com>)
# Cookbook Name:: zipkin
# Recipe:: _setup
#

group node['zipkin']['group'] do
  gid node['zipkin']['gid'] if node['zipkin']['gid']
  only_if { node['zipkin']['manage_user'] }
end

user node['zipkin']['user'] do
  uid node['zipkin']['uid'] if node['zipkin']['uid']
  group node['zipkin']['group']
  home node['zipkin']['install_dir']
  shell '/bin/false'
  only_if { node['zipkin']['manage_user'] }
end
