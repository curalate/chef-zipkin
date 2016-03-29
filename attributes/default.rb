#
# Author:: Rich Schumacher (<rich@curalate.com>)
# Cookbook Name:: zipkin
# Attributes:: default
#

# Base configuration
default['zipkin']['config_key'] = 'dev'
default['zipkin']['install_dir'] = '/opt/zipkin'
default['zipkin']['install_method'] = 'source'
default['zipkin']['user'] = 'zipkin'
default['zipkin']['phantomjs_cdn_url'] = nil

# Source installation configuration
default['zipkin']['source']['repo'] = 'https://github.com/openzipkin/zipkin'
default['zipkin']['source']['ref'] = 'master'

# Collector configuration
default['zipkin']['collector']['admin_port'] = nil
default['zipkin']['collector']['log_level'] = nil
default['zipkin']['collector']['port'] = nil
default['zipkin']['collector']['sample_rate'] = nil
default['zipkin']['collector']['cassandra']['contact_points'] = nil
default['zipkin']['collector']['cassandra']['ensure_schema'] = nil
default['zipkin']['collector']['cassandra']['local_dc'] = nil
default['zipkin']['collector']['cassandra']['max_connections'] = nil
default['zipkin']['collector']['cassandra']['password'] = nil
default['zipkin']['collector']['cassandra']['username'] = nil
default['zipkin']['collector']['kafka']['group_id'] = nil
default['zipkin']['collector']['kafka']['streams'] = nil
default['zipkin']['collector']['kafka']['topic'] = nil
default['zipkin']['collector']['kafka']['zookeeper'] = nil
default['zipkin']['collector']['mysql']['db'] = nil
default['zipkin']['collector']['mysql']['host'] = nil
default['zipkin']['collector']['mysql']['max_connections'] = nil
default['zipkin']['collector']['mysql']['pass'] = nil
default['zipkin']['collector']['mysql']['tcp_port'] = nil
default['zipkin']['collector']['mysql']['use_ssl'] = nil
default['zipkin']['collector']['mysql']['user'] = nil

# Query configuration
default['zipkin']['query']['admin_port'] = nil
default['zipkin']['query']['log_level'] = nil
default['zipkin']['query']['port'] = nil
default['zipkin']['query']['cassandra']['contact_points'] = nil
default['zipkin']['query']['cassandra']['ensure_schema'] = nil
default['zipkin']['query']['cassandra']['local_dc'] = nil
default['zipkin']['query']['cassandra']['max_connections'] = nil
default['zipkin']['query']['cassandra']['password'] = nil
default['zipkin']['query']['cassandra']['username'] = nil
default['zipkin']['query']['mysql']['db'] = nil
default['zipkin']['query']['mysql']['host'] = nil
default['zipkin']['query']['mysql']['max_connections'] = nil
default['zipkin']['query']['mysql']['pass'] = nil
default['zipkin']['query']['mysql']['tcp_port'] = nil
default['zipkin']['query']['mysql']['use_ssl'] = nil
default['zipkin']['query']['mysql']['user'] = nil

# Web configuration
default['zipkin']['web']['log_level'] = nil
default['zipkin']['web']['scribe']['host'] = nil
default['zipkin']['web']['scribe']['port'] = nil
default['zipkin']['web']['transport_type'] = nil
default['zipkin']['web']['query']['dest'] = nil
