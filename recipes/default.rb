#
# Author:: Rich Schumacher (<rich@curalate.com>)
# Cookbook Name:: zipkin
# Recipe:: default
#

include_recipe 'java'
include_recipe "zipkin::#{node['zipkin']['install_method']}"
