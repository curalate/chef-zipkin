#
# Author:: Rich Schumacher (<rich@curalate.com>)
# Cookbook Name:: zipkin
# Spec:: web
#

require_relative './spec_helper'

describe 'zipkin::web' do
  describe service('zipkin-web') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(8080) do
    it { should be_listening.with('tcp6') }
  end
end
