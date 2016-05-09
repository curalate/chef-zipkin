chef-zipkin Cookbook
====================

This cookbook installs and configures the Zipkin distributed tracing system.
There are recipes provided for each of the three components: collector, query,
and web.

Currently, the cookbook only supports installation from a source code checkout
using the provided Gradle wrappers. At this time the cookbook doesn't support
installing from networked package managers (like Apt or Yum) since Zipkin
doesn't provide package repositories.

## Requirements

Chef 11+

### Platforms

This cookbook uses Test Kitchen to do cross-platform convergence and
post-convergence tests. The tested platforms are considered supported. This
cookbook may work on other platforms or platform versions with or without
modification.

* Ubuntu 12.04, 14.04

### Cookbooks

* java (Note that Zipkin requires Java 7+)

## Attributes

Attributes have default values set in `attributes/default.rb`. Attributes for
individual Zipkin components default to `nil`, meaning that they fall back to
the defaults used by the Zipkin code.

General attributes:

* `node['zipkin']['config_key']`: Determines where the data is stored, one
  of: `dev`, `cassandra`, `mysql`. Defaults to `dev`.
* `node['zipkin']['install_dir']`: Where to install the application. Defaults
  to `/opt/zipkin`.
* `node['zipkin']['install_method']`: Installation method. Defaults to
  `source` as that is the only supported method currently.
* `node['zipkin']['user']`: User to run the daemon as. Defaults to `zipkin`.
* `node['zipkin']['phantomjs_cdn_url']`: Use an alternative PhantomJS CDN to
  download from. This is provided as Bitbucket is the default and has been
  known to heavily throttle the downloads, breaking installation. nodes to
  `nil`

Source installation configuration:

* `node['zipkin']['source']['repo']`: Repository to build from. Defaults to
  `https://github.com/openzipkin/zipkin`.
* `node['zipkin']['source']['ref']`: Git ref to build from. Defaults to
  `master`.

Collector configuration:

* `node['zipkin']['collector']['admin_port']` = `nil`
* `node['zipkin']['collector']['log_level']` = `nil`
* `node['zipkin']['collector']['port']` = `nil`
* `node['zipkin']['collector']['sample_rate']` = `nil`
* `node['zipkin']['collector']['cassandra']['contact_points']` = `nil`
* `node['zipkin']['collector']['cassandra']['ensure_schema']` = `nil`
* `node['zipkin']['collector']['cassandra']['local_dc']` = `nil`
* `node['zipkin']['collector']['cassandra']['max_connections']` = `nil`
* `node['zipkin']['collector']['cassandra']['password']` = `nil`
* `node['zipkin']['collector']['cassandra']['username']` = `nil`
* `node['zipkin']['collector']['kafka']['group_id']` = `nil`
* `node['zipkin']['collector']['kafka']['streams']` = `nil`
* `node['zipkin']['collector']['kafka']['topic']` = `nil`
* `node['zipkin']['collector']['kafka']['zookeeper']` = `nil`
* `node['zipkin']['collector']['mysql']['db']` = `nil`
* `node['zipkin']['collector']['mysql']['host']` = `nil`
* `node['zipkin']['collector']['mysql']['max_connections']` = `nil`
* `node['zipkin']['collector']['mysql']['pass']` = `nil`
* `node['zipkin']['collector']['mysql']['tcp_port']` = `nil`
* `node['zipkin']['collector']['mysql']['use_ssl']` = `nil`
* `node['zipkin']['collector']['mysql']['user']` = `nil`

Query configuration:

* `node['zipkin']['query']['admin_port']` = `nil`
* `node['zipkin']['query']['log_level']` = `nil`
* `node['zipkin']['query']['lookback']` = `nil`
* `node['zipkin']['query']['port']` = `nil`
* `node['zipkin']['query']['cassandra']['contact_points']` = `nil`
* `node['zipkin']['query']['cassandra']['ensure_schema']` = `nil`
* `node['zipkin']['query']['cassandra']['local_dc']` = `nil`
* `node['zipkin']['query']['cassandra']['max_connections']` = `nil`
* `node['zipkin']['query']['cassandra']['password']` = `nil`
* `node['zipkin']['query']['cassandra']['username']` = `nil`
* `node['zipkin']['query']['mysql']['db']` = `nil`
* `node['zipkin']['query']['mysql']['host']` = `nil`
* `node['zipkin']['query']['mysql']['max_connections']` = `nil`
* `node['zipkin']['query']['mysql']['pass']` = `nil`
* `node['zipkin']['query']['mysql']['tcp_port']` = `nil`
* `node['zipkin']['query']['mysql']['use_ssl']` = `nil`
* `node['zipkin']['query']['mysql']['user']` = `nil`

Web configuration:

* `node['zipkin']['web']['log_level']` = `nil`
* `node['zipkin']['web']['scribe']['host']` = `nil`
* `node['zipkin']['web']['scribe']['port']` = `nil`
* `node['zipkin']['web']['transport_type']` = `nil`
* `node['zipkin']['web']['query']['dest']` = `nil`


## Recipes

### default

The default recipe installs Java via the `java` cookbook and will then install
Zipkin by including the appropriate installation recipe. As noted, only the
`source` installation method is supported.

### source

Checks out the code and builds all the components (collector, query, and web)
via the `./gradlew` script. This also installs the Upstart configs for these
components. Note that the individual daemons are not started.

### collector

Includes the `zipkin::default` recipe and then enables and starts the
`zipkin-collector` daemon.

### query

Includes the `zipkin::default` recipe and then enables and starts the
`zipkin-query` daemon.

### web

Includes the `zipkin::default` recipe and then enables and starts the
`zipkin-web` daemon.

## Usage

Simple include the appropriate recipe dependingo on what component you wish
to install:

* zipkin::collector
* zipkin::query
* zipkin::web


## License and Author

Author:: Rich Schumacher

Copyright:: 2016, Curalate, Inc.

Released under the [MIT License](http://www.opensource.org/licenses/MIT).
