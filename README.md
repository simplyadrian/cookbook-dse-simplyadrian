dse-nativex Cookbook
====================
# Datastax Enterprise Chef Cookbook (Apache Cassandra)
This cookbook installs and configures Datastax Enterprise. More info is here ([DataStax Enterprise](http://www.datastax.com/products/)).

It uses officially released Datastax packages. It can tweak the Cassandra config files, but has no way of adding data or creating keyspaces in Cassandra (yet).

## Usage

Override the attributes you wish to change and use the dse-nativex:cassandra recipe to install Apache Cassandra.

##Scope

This cookbook attempts to manage almost all Apache Cassandra configuration settings.

### Apache Cassandra

This cookbook currently provides

 * Datastax 4.5.x (Datastax Enterprise Edition) via packages.

## Requirements

* Chef 11 or higher

## Supported OS Distributions
Tested on:

* CentOS 6.5

## Recipes

The provided recipes are `dse-nativex::cassandra`.
* `dse-nativex::cassandra` will provision DSE as a cassandra node.


There are also recipes that should not be called directly that are used for configuration.
* `dse-nativex::default` sets up the templates
* `dse-nativex::datastax` sets up the datastax repos
* `dse-nativex::datstax-agent` configures the datastax-agent if needed

## Attributes
This cookbook will install DSE Cassandra by default. Other attributes you can set are:

### default.rb

#### overall settings
 * `node["cassandra"]["cluster_name"]` (default: `Test Cluster`): The name of the cluster to provision
 * `node["cassandra"]["vnodes"]` (default: `true`): enable or disable vnodes
 * `node["cassandra"]["intial_token"]` (default: `nil`): the initial token to use. leave blank for vnodes
 * `node["cassandra"]["num_tokens"]` (default: `256`): set the number of tokens to use
 * `node["cassandra"]["solr"]` (default: `false`): enable solr or not
 * `node["cassandra"]["hadoop"]` (default: `false`): enable hadoop or not

 * `node["cassandra"]["dse_version"]` (default: `4.0.3-1`): dse version to install
 * `node["cassandra"]["user"]` (default: `cassandra`): the cassandra user
 * `node["cassandra"]["group"]` (default: `cassandra`): the cassandra group

#### cassandra.yaml settings
 * `node["cassandra"]["listen_address"]` (default: `node['ipaddress']`): the ipaddress to use for listen address
 * `node["cassandra"]["rpc_address"]` (default: `node['ipaddress']`): the ipaddress to use for rpc address
 * `node["cassandra"]["broadcast_address"]` (default: `nil`): the ipaddress to use for broadcast address
 * `node["cassandra"]["seeds"]` (default: `node['ipaddress']`): the ipaddress to use for the seed list
 * `node["cassandra"]["concurrent_reads"]` (default: `32`): concurrent reads setting
 * `node["cassandra"]["concurrent_writes"]` (default: `32`): concurrent writes setting
 * `node["cassandra"]["compaction_thruput"]` (default: `16`): limit the throughput of compactions
 * `node["cassandra"]["multithreaded_compaction"]` (default: `false`): enable or disable multithreaded compaction
 * `node["cassandra"]["in_memory_compaction_limit"]` (default: `64`): size limit for in-memory compactions
 * `node["cassandra"]["trickle_fsync"]` (default: `false`): enable trickle fsync, usually for ssd
 * `node["cassandra"]["range_request_timeout_in_ms"]` (default: `10000`): default timeout on range requests
 * `node["cassandra"]["thrift_framed_transport_size_in_mb"]` (default: `15`): the max size of a thrift frame
 * `node["cassandra"]["thrift_max_message_length_in_mb"]` (default: `nil`): the max message length of a thrift call
 * `node["cassandra"]["concurrent_compactors"]` (default: `nil`): the number of concurrent compactors to allow

#### gc settings

 * `node["cassandra"]["CMSInitiatingOccupancyFraction"]` (default: `65`): cms occupancy fraction to use for gc
 * `node["cassandra"]["max_heap_size"]` (default: `8192M`): default max heap size for cassandra
 * `node["cassandra"]["heap_newsize"]` (default: `800M`): default new gen size for heap

#### authentication settings
 * `node["cassandra"]["authentication"]` (default: `false`): enable or disable authentication
 * `node["cassandra"]["authorization"]` (default: `false`): enable or disable authorization
 * `node["cassandra"]["authenticator"]` (default: ``): the authenticator to use (eg org.apache.cassandra.auth.AllowAllAuthenticator)
 * `node["cassandra"]["authorizor"]` (default: ``): the authorizor to use (eg org.apache.cassandra.auth.AllowAllAuthorizer)

#### audit logs
 * `node["cassandra"]["log_level"]` (default: `INFO`): the log level for cassandra (or solr/hadoop)
 * `node["cassandra"]["audit_logging"]` (default: `false`): turn on audit logging
 * `node["cassandra"]["audit_dir"]` (default: `/var/log/cassandra`): the directory to put audit logs in
 * `node["cassandra"]["active_categories"]` (default: `ADMIN,AUTH,DDL,DCL`): the categories to audit on

### dse.rb
 * `node["cassandra"]["dse"]["service_name"]` (default: `dse`): the name of the service
 * `node["cassandra"]["dse"]["conf_dir"]` (default: `/etc/dse`): the directory of dse config files
 * `node["cassandra"]["dse"]["repo_user"]` (default: ``): the datastax username for the repo
 * `node["cassandra"]["dse"]["repo_password"]` (default: ``): the datastax password for the repo
 * `node["cassandra"]["dse"]["rhel_repo_url"]` (default: `http://#{node['cassandra']['dse']['repo_user']}:#{node['cassandra']['dse']['repo_pass']}@rpm.datastax.com/enterprise`): the rhel repo

### java.rb
These are generic java settings. Datastax recommends oracle java, so override openjdk default and download from a specific location.
 * `node["dse"]["manage_java"]` (default: `true`): whether or not to use the java recipe to manage the java install
 * `node["java"]["install_flavor"]` (default: `oracle`): the flavor of java to install
 * `node["java"]["jdk_version"]` (default: `7`): the version of java to use
 * `node['java']['jdk']['7']['x86_64']['url']` (default: ``): the url to get the java 7 file from

### datastax-agent.rb
These attributes are used to conigure the datastax-agent. This is used with Datastax Opscenter.

* `node["datastax-agent"]["enabled"]` (default: `false`): whether to install the datastax agent and configure
* `node["datastax-agent"]["version"]` (default: `4.1.1-1`): the version of the datastax agent to install
* `node["datastax-agent"]["conf_dir"]` (default: `/var/lib/datastax-agent/conf`): where the datastax-agent conf file is
* `node["datastax-agent"]["opscenter_ip"]` (default: `192.168.32.3`): the Opscenter IP to connect to


## Dependencies

* java
* yum

Datastax recommends to use the Oracle jdk version. You can do this by setting an attribute in your environment or run list.

## Copyright & License

Some, but not all, of the components of this cookbook are based on the work of Target's DSE cookbook (https://supermarket.getchef.com/cookbooks/dse)

- Author: Daniel Parker (<danel.c.parker@target.com>)
- Reviewer: Eric Helgeson (<erichelgeson@gmail.com>)

Released under the [Apache 2.0 License](http://www.apache.org/licenses/LICENSE-2.0.html).

At NativeX:
	- Author: Derek Bromenshenkel (<derek.bromenshenkel@gmail.com>)

