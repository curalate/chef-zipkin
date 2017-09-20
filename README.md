chef-zipkin Cookbook
====================

This cookbook installs and configures the Zipkin distributed tracing system.

## Requirements

Chef 12+

### Platforms

This cookbook uses Test Kitchen to do cross-platform convergence and
post-convergence tests. The tested platforms are considered supported. This
cookbook may work on other platforms or platform versions with or without
modification.

* Ubuntu 12.04, 14.04

Note that Upstart is the only supported init system currently.

### Cookbooks

This cookbook does not depend on any other cookbooks but Java is required to
to run Zipkin. Therefore, the `java` cookbook is recommended.

## Attributes

Attributes have default values set in `attributes/default.rb`. Configuration
for the various Zipkin components (collector, storage, etc.) is done entirely
via environment variables. In an effort to support a flexible configuration
pattern the `node['zipkin']['env_vars']` hash is provided. Configuration
key-value pairs should be placed in here and they will be exported as
environment variables in the startup script. This hash is intended to be one
level deep and the keys will be uppercased and exported.

For instance, given the following attribute configuration:
```
default['zipkin']['env_vars']['query_port'] = 8080
default['zipkin']['env_vars']['storage_type'] = 'mysql'
default['zipkin']['env_vars']['mysql_user'] = 'buster'
default['zipkin']['env_vars']['mysql_pass'] = 'motherboy'
default['zipkin']['env_vars']['mysql_use_ssl'] = true
default['zipkin']['env_vars']['zipkin_ui_environment'] = 'qa'
```

Will produce the following values in the init script:
```
export QUERY_PORT="8080"
export STORAGE_TYPE="mysql"
export MYSQL_USER="buster"
export MYSQL_PASS="motherboy"
export MYSQL_USE_SSL="true"
export ZIPKIN_UI_ENVIRONMENT="qa"
```

General attributes:

* `node['zipkin']['version']`: Version to install.
* `node['zipkin']['install_dir']`: Where to install the application. Defaults
to `/opt/zipkin`.
* `node['zipkin']['manage_user']`: Should we create the user and group?
* `node['zipkin']['user']`: User to run the daemon as. Defaults to `zipkin`.
* `node['zipkin']['group']`: Group to run the daemon as. Defaults to `zipkin`.
* `node['zipkin']['uid']`: User ID for the Zipkin user.
* `node['zipkin']['gid']`: Group ID for the Zipkin group.


## Recipes

### default

Configures the system, installs the JARs, and generates the Upstart
configuration.

### _install

Fetches the relevant JARs from Maven Central and drops them into the
configured installation directory.

### _setup

Performs required system configuration such as creating the required user and
group with which to run Zipkin.

## Usage

Simply set your attributes and include the `zipkin::default` recipe.

## License and Author

Author:: Rich Schumacher

Copyright:: 2016-2017, Curalate, Inc.

Released under the [MIT License](http://www.opensource.org/licenses/MIT).
