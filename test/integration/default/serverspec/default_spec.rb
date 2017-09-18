#
# Author:: Rich Schumacher (<rich@curalate.com>)
# Cookbook Name:: zipkin
# Spec:: default
#

require_relative './spec_helper'

describe 'zipkin::_setup' do
  describe group('zipkin') do
    it { should exist }
  end

  describe user('zipkin') do
    it { should exist }
    it { should have_home_directory '/opt/zipkin' }
    it { should belong_to_group 'zipkin' }
  end
end

describe 'zipkin::_install' do
  describe file('/opt/zipkin') do
    it { should be_symlink }
    it { should be_linked_to '/opt/zipkin-2.0.0' }
    it { should be_owned_by 'zipkin' }
  end

  describe file('/opt/zipkin-2.0.0') do
    it { should be_directory }
    it { should be_owned_by 'zipkin' }
  end

  describe file('/opt/zipkin-2.0.0/zipkin.jar') do
    it { should be_file }
    it { should be_owned_by 'zipkin' }
  end
end

describe 'zipkin::default' do
  describe service('zipkin') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(9411) do
    it { should be_listening.with('tcp') }
  end
end
