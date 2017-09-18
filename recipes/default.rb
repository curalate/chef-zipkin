#
# Author:: Rich Schumacher (<rich@curalate.com>)
# Cookbook Name:: zipkin
# Recipe:: default
#

include_recipe 'zipkin::_setup'
include_recipe 'zipkin::_install'

template '/etc/init/zipkin.conf' do
  source 'upstart.conf.erb'
  mode '0644'
  action :create
  variables(
    user: node['zipkin']['user']
  )
end

service 'zipkin' do
  provider Chef::Provider::Service::Upstart
  supports(
    start:   true,
    stop:    true,
    restart: true,
    status:  true
  )
  action %i[enable start]
end
