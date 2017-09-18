name             'zipkin'
maintainer       'Curalate, Inc.'
maintainer_email 'rich@curalate.com '
license          'MIT'
description      'Installs and configures Zipkin, a distributed tracing system.'
long_description 'Installs and configures Zipkin, a distributed tracing system.'
version          '0.3.0'
source_url       'https://github.com/curalate/chef-zipkin' if respond_to?(:source_url)
issues_url       'https://github.com/curalate/chef-zipkin/issues' if respond_to?(:issues_url)

chef_version     '>= 12.0' if respond_to?(:chef_version)

supports 'ubuntu'
