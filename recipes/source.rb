#
# Author:: Rich Schumacher (<rich@curalate.com>)
# Cookbook Name:: zipkin
# Recipe:: source
#

::Chef::Resource::Template.send(:include, Zipkin::Helpers)

package 'git'
package 'libfontconfig'

zipkin_user = node['zipkin']['user']
install_dir = node['zipkin']['install_dir']

user zipkin_user do
  home install_dir
  shell '/bin/false'
end

git install_dir do
  repository node['zipkin']['source']['repo']
  revision node['zipkin']['source']['hash']
  action :sync
end

bash 'chown-home' do
  cwd install_dir
  code "chown -R #{zipkin_user}:#{zipkin_user} ."
end

%w( collector query web ).each do |app|
  file "/var/log/zipkin-#{app}.log" do
    mode '0755'
    owner zipkin_user
    group zipkin_user
    action :create
  end
end

# Collector
bash 'build-zipkin-collector' do
  cwd install_dir
  code './gradlew --no-daemon :zipkin-collector-service:build'
  user zipkin_user
  group zipkin_user
  environment(
    HOME:             install_dir,
    PHANTOMJS_CDNURL: node['zipkin']['phantomjs_cdn_url']
  )
end

template '/etc/init/zipkin-collector.conf' do
  source 'upstart.conf.erb'
  mode '0644'
  action :create
  variables(
    config_key: node['zipkin']['config_key'],
    env_vars:   generate_environment_variables('collector', node['zipkin']['collector']),
    path:       "#{install_dir}/zipkin-collector-service",
    service:    'collector',
    user:       zipkin_user
  )
end

# Query
bash 'build-zipkin-query' do
  cwd install_dir
  code './gradlew --no-daemon :zipkin-query-service:build'
  user zipkin_user
  group zipkin_user
  environment(
    HOME:             install_dir,
    PHANTOMJS_CDNURL: node['zipkin']['phantomjs_cdn_url']
  )
end

template '/etc/init/zipkin-query.conf' do
  source 'upstart.conf.erb'
  mode '0644'
  action :create
  variables(
    config_key: node['zipkin']['config_key'],
    env_vars:   generate_environment_variables('query', node['zipkin']['query']),
    path:       "#{install_dir}/zipkin-query-service",
    service:    'query',
    user:       zipkin_user
  )
end

# Web
bash 'build-zipkin-web' do
  cwd install_dir
  code './gradlew --no-daemon :zipkin-web:build'
  user zipkin_user
  group zipkin_user
  environment(
    HOME:             install_dir,
    PHANTOMJS_CDNURL: node['zipkin']['phantomjs_cdn_url']
  )
end

template '/etc/init/zipkin-web.conf' do
  source 'upstart.conf.erb'
  mode '0644'
  action :create
  variables(
    config_key: node['zipkin']['config_key'],
    env_vars:   generate_environment_variables('web', node['zipkin']['web']),
    jvm_args:   generate_jvm_arguments('zipkin.web', node['zipkin']['web']),
    path:       "#{install_dir}/zipkin-web",
    service:    'web',
    user:       zipkin_user
  )
end
