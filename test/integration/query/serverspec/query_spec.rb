#
# Author:: Rich Schumacher (<rich@curalate.com>)
# Cookbook Name:: zipkin
# Spec:: query
#

require_relative './spec_helper'

describe 'zipkin::query' do
  describe service('zipkin-query') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(9411) do
    it { should be_listening.with('tcp6') }
  end

  describe port(9901) do
    it { should be_listening.with('tcp6') }
  end
end
