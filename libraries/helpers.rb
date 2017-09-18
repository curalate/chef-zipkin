#
# Author:: Rich Schumacher (<rich@curalate.com>)
# Cookbook Name:: zipkin
# Libraries:: helpers
#

def zipkin_jar_file
  'zipkin.jar'
end

def zipkin_kafka_jar_file
  'zipkin-collector-kafka.jar'
end

def zipkin_jar_path
  ::File.join(zipkin_version_dir, zipkin_jar_file)
end

def zipkin_kafka_jar_path
  ::File.join(zipkin_version_dir, zipkin_kafka_jar_file)
end

def zipkin_version_dir
  "#{node['zipkin']['install_dir']}-#{node['zipkin']['version']}"
end

def zipkin_env_vars
  env_vars = {}
  node['zipkin']['env_vars'].each do |k, v|
    env_vars[k] = v
  end
  env_vars.delete_if { |_, v| v.nil? }.map { |k, v| [k.upcase, v] }.to_h.sort.to_h
end
