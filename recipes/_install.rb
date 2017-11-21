#
# Author:: Rich Schumacher (<rich@curalate.com>)
# Cookbook Name:: zipkin
# Recipe:: _install
#

install_dir = node['zipkin']['install_dir']
zipkin_user = node['zipkin']['user']

directory zipkin_version_dir do
  owner zipkin_user
  group zipkin_user
  mode '755'
  recursive true
end

link install_dir do
  owner zipkin_user
  group zipkin_user
  to zipkin_version_dir
end

remote_file zipkin_jar_path do
  source zipkin_jar_remote_url
  owner zipkin_user
  group zipkin_user
  mode '0755'
  action :create
end

remote_file zipkin_kafka_jar_path do
  source zipkin_kafka_jar_remote_url
  owner zipkin_user
  group zipkin_user
  mode '0755'
  action :create
end
