#
# Author:: Rich Schumacher (<rich@curalate.com>)
# Cookbook Name:: zipkin
# Libraries:: helpers
#

module Zipkin
  # Helper methods used to generate hashes for environment variables and JVM
  # arguments. The templates are expected to format these as needed.
  module Helpers
    def generate_environment_variables(prefix, input_hash, vars_accum = {})
      input_hash.each_pair do |k, v|
        if v.is_a?(Hash)
          generate_environment_variables(k, v, vars_accum)
        elsif prefix == 'web' && k.casecmp('transport_type') == 0
          vars_accum[k] = v
        else
          vars_accum["#{prefix}_#{k}"] = v
        end
      end
      vars_accum.delete_if { |_, v| v.nil? }.map { |k, v| [k.upcase, v] }.to_h.sort.to_h
    end

    def generate_jvm_arguments(prefix, input_hash, args_accum = {})
      input_hash.each_pair do |k, v|
        if v.is_a?(Hash)
          generate_jvm_arguments("#{prefix}.#{k}", v, args_accum)
        else
          args_accum["#{prefix}.#{k}"] = v
        end
      end
      args_accum.delete_if { |_, v| v.nil? }
    end
  end
end
