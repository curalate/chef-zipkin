#
# Author:: Rich Schumacher (<rich@curalate.com>)
# Cookbook Name:: zipkin
# Recipe:: query
#

include_recipe 'zipkin::default'

service 'zipkin-query' do
  provider Chef::Provider::Service::Upstart
  supports(
    start:   true,
    stop:    true,
    restart: true,
    status:  true
  )
  action [:enable, :start]
end
