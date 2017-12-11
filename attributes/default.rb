#
# Author:: Rich Schumacher (<rich@curalate.com>)
# Cookbook Name:: zipkin
# Attributes:: default
#

# Base configuration
default['zipkin']['install_dir'] = '/opt/zipkin'
default['zipkin']['version'] = '2.4.0'
default['zipkin']['maven_base_url'] = 'https://repo1.maven.org/maven2'
default['zipkin']['user'] = 'zipkin'
default['zipkin']['group'] = 'zipkin'
default['zipkin']['uid'] = nil
default['zipkin']['gid'] = nil
default['zipkin']['manage_user'] = true

# Server configuration
default['zipkin']['env_vars']['collector_sample_rate'] = nil
default['zipkin']['env_vars']['query_port'] = nil
default['zipkin']['env_vars']['storage_type'] = nil
