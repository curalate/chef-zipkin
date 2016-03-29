#
# Author:: Rich Schumacher (<rich@curalate.com>)
# Cookbook Name:: zipkin
# Spec:: collector
#

require_relative './spec_helper'

describe 'zipkin::collector' do
  describe service('zipkin-collector') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(9410) do
    it { should be_listening.with('tcp6') }
  end

  describe port(9900) do
    it { should be_listening.with('tcp6') }
  end
end
