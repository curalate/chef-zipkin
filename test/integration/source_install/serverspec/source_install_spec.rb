#
# Author:: Rich Schumacher (<rich@curalate.com>)
# Cookbook Name:: zipkin
# Spec:: source_install
#

require_relative './spec_helper'

describe 'zipkin::default' do
  describe package('git') do
    it { should be_installed }
  end

  describe command('which java') do
    its(:exit_status) { should eq 0 }
  end

  describe user('zipkin') do
    it { should exist }
    it { should have_home_directory '/opt/zipkin' }
  end

  describe file('/opt/zipkin') do
    it { should be_directory }
    it { should be_owned_by 'zipkin' }
  end

  %w( collector query web ).each do |app|
    describe file("/var/log/zipkin-#{app}.log") do
      it { should be_file }
      it { should be_mode 755 }
      it { should be_owned_by 'zipkin' }
    end
  end

  %w( collector query web ).each do |app|
    describe file("/etc/init/zipkin-#{app}.conf") do
      it { should be_file }
      it { should be_mode 644 }
      it { should be_owned_by 'root' }
      its(:content) { should match 'setuid' }
      its(:content) { should match "com.twitter.zipkin.#{app}.Main" }
      its(:content) { should match "/var/log/zipkin-#{app}.log" }
    end
  end

  describe file('/etc/init/zipkin-collector.conf') do
    its(:content) { should match 'COLLECTOR_PORT="1313"' }
    its(:content) { should match 'CASSANDRA_KEYSPACE="bluth"' }
  end

  describe file('/etc/init/zipkin-web.conf') do
    its(:content) { should match 'WEB_LOG_LEVEL="WARN"' }
    its(:content) { should match 'TRANSPORT_TYPE="scribe"' }
    its(:content) { should match 'SCRIBE_PORT="1313"' }
    its(:content) { should match '-zipkin.web.port=3131' }
    its(:content) { should match '-zipkin.web.query.dest=127.0.0.1:1313' }
  end
end
