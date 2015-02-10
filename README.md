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

 * v0.1.0: Datastax 4.5.3 (Datastax Enterprise Edition) via packages.
 * v1.0.0: Datastax 4.6.0 (Datastax Enterprise Edition) via packages.

## Requirements

* Chef 11 or higher

## Supported OS Distributions
Tested on:

* CentOS 6.5 & 6.6

## Recipes
The provided recipes are:

* `dse-nativex::default`: Sets up the default installation which is to install Apache Cassandra DSE component only (with suggested OS configuration), alongside an OpsCenter agent.
* `dse-nativex::cassandra`: Configures the the templates for config files in /etc/dse/.
* `dse-nativex::datastax`: Sets up Java and installs the 'dse-full' package. Ensures the data/saved_caches/commit_log directories exist.
* `dse-nativex::determine_ec2_topology`: When running in EC2, automatically sets the Datacenter==AWS Region and Rack=AWS Availability Zone
* `dse-nativex::determine_seeds`: Optionally can be used to autodetect the first `default['cassandra']['num_seeds_per_dc']` nodes in each datacenter to join the cluster as seeds.
* `dse-nativex::dse_service`: Manages the DSE service.
* `dse-nativex::jemalloc`: Installs the JEMalloc package/library on the system to make it available as one of the Off-heap memory allocators.
* `dse-nativex::jna`: Installs the JNA library on the system. See: http://www.datastax.com/documentation/cassandra/2.0/cassandra/install/installJnaTar.html
* `dse-nativex::opscenter-agent`: Installs (via datastax-agent package) the OpsCenter agent and configures it.
* `dse-nativex::os_settings`: Configures OS limits and other OS-specific settings

## Attributes
This cookbook will install DSE Cassandra by default. If no attributes are overridden, it will install with the default cassandra.yaml settings found in the Apache Cassandra project.

### cassandra.rb

#### overall settings
 * `node["cassandra"]["cluster_name"]` (default: `Test Cluster`): The name of the cluster to provision
 * `node["cassandra"]["vnodes"]` (default: `true`): enable or disable vnodes
 * `node["cassandra"]["intial_token"]` (default: `nil`): the initial token to use. leave blank for vnodes
 * `node["cassandra"]["num_tokens"]` (default: `256`): set the number of tokens to use
 * `node["cassandra"]["solr"]` (default: `false`): enable solr or not - Currently does not support Solr config.
 * `node["cassandra"]["hadoop"]` (default: `false`): enable hadoop or not - Currently does not support Hadoop config.
 * `node["cassandra"]["dse_version"]` (default: `4.5.3-1`): dse version to install
 * `node["cassandra"]["user"]` (default: `cassandra`): the cassandra user
 * `node["cassandra"]["group"]` (default: `cassandra`): the cassandra group
 * More in the file itself.

#### cassandra.yaml settings
 * Too many to list. Encompasses nearly all available settings in cassandra.yaml. See the file itself.  Defaults are set to whatever is in the Apache Cassandra project.

#### gc settings
 * `node['cassandra']['max_heap_size']`: (default: `nil` Use the formula in cassandra-env.sh)
 * `node['cassandra']['heap_newsize']`: (default: `nil` Use the formula in cassandra-env.sh)
 * `node['cassandra']['jvm_gc_SurvivorRatio']`: (default: `8`)
 * `node['cassandra']['jvm_gc_MaxTenuringThreshold']`: (default: `1`)
 * `node['cassandra']['jvm_gc_CMSInitiatingOccupancyFraction']`: (default: `"75"`)
 * `node['cassandra']['jvm_gc_UseNUMA']`: (default: `false`)

#### authentication settings
 * `node["cassandra"]["authenticator"]` (default: ``): the authenticator to use (eg org.apache.cassandra.auth.AllowAllAuthenticator)
 * `node["cassandra"]["authorizor"]` (default: ``): the authorizor to use (eg org.apache.cassandra.auth.AllowAllAuthorizer)

#### Log4J Settings
 * `node['cassandra']['log_level']`: (default: `"INFO"`): the log level for cassandra (or solr/hadoop)
 * `node['cassandra']['log_file_size_mb']`: (default: `"20"`)
 * `node['cassandra']['log_file_roll_count']`: (default: `10`)
##### audit logs
 * `node["cassandra"]["audit_logging"]` (default: `false`): turn on audit logging
 * `node["cassandra"]["audit_dir"]` (default: `/var/log/cassandra`): the directory to put audit logs in
 * `node["cassandra"]["active_categories"]` (default: `ADMIN,AUTH,DDL,DCL`): the categories to audit on
##### nativex Syslog Settings
 * `node['cassandra']['log_syslog_enabled']`: (default: `false`)
 * `node['cassandra']['log_syslog_host']`: (default: `""`) IP or hostname of syslog server.
 * `node['cassandra']['log_syslog_threshold']`: (default: `"WARN"`) The level to log to Syslog.

#### JNA Settings (3.2.7 or higher required for C* 2.0 and 2.1)
 * `node['cassandra']['jna_version']`: (default: `"3.5.2"`)
 * `node['cassandra']['jna_install_dir']`: (default: `node['cassandra']['jar_lib_dir']`)
 * `node['cassandra']['jna_jar_source_base_uri']`: (default: `"https://maven.java.net/content/repositories/releases/net/java/dev/jna/jna/"`)

#### JEMalloc Settings
 * `node['cassandra']['jemalloc_location']`: (default: `"/usr/lib64/"`) JEMalloc install location.

#### OS settings for Cassandra (See: http://www.datastax.com/documentation/cassandra/2.0/cassandra/install/installRecommendSettings.html)
 * `node['cassandra']['os']['zone_reclaim_mode']`: (default: `0`)
 * `node['cassandra']['os']['limits_ary']`: (default: `[
                                                                       { 'domain' => 'cassandra', 'type' => '-', 'item' => 'memlock', 'value' => 'unlimited' },
                                                                       { 'domain' => 'cassandra', 'type' => '-', 'item' => 'nofile', 'value' => '100000' },
                                                                       { 'domain' => 'cassandra', 'type' => '-', 'item' => 'nproc', 'value' => '32768' },
                                                                       { 'domain' => 'cassandra', 'type' => '-', 'item' => 'as', 'value' => 'unlimited' }
                                                                      ]`)
 * `node['cassandra']['os']['90_nproc_limits_ary']`: (default: `[
                                                                       { 'domain' => 'root', 'type' => 'soft', 'item' => 'nproc', 'value' => 'unlimited' },
                                                                       { 'domain' => '*', 'type' => '-', 'item' => 'nproc', 'value' => '32768' }
                                                                      ]`)
 * `node['cassandra']['os']['sysctl_vm_max_map_count']`: (default: `131072`)

### dse.rb
 * `node["cassandra"]["dse"]["service_name"]` (default: `dse`): the name of the service
 * `node["cassandra"]["dse"]["conf_dir"]` (default: `/etc/dse`): the directory of dse config files
 * Other 'dse.yaml' settings.

### java.rb
These are generic java settings. Datastax recommends oracle java, so override openjdk default and download from a specific location.

 * `node["dse"]["manage_java"]` (default: `true`): whether or not to use the java recipe to manage the java install
 * `node["java"]["install_flavor"]` (default: `oracle`): the flavor of java to install
 * `node["java"]["jdk_version"]` (default: `7`): the version of java to use
 * `node['java']['jdk']['7']['x86_64']['url']` (default: ``): the url to get the java 7 file from

### opscenter-agent.rb
These attributes are used to conigure the datastax-agent. This is used with Datastax Opscenter.

* `node['opscenter-agent']['enabled']`: (default: `false`)
* `node['opscenter-agent']['version']`: (default: `"5.0.1-1"`)
* `node['opscenter-agent']['conf_dir']`: (default: `"/var/lib/datastax-agent/conf"`)
* `node['opscenter-agent']['opscenter-ip']`: (default: `"127.0.0.1"`)
* `node['opscenter-agent']['opscenter_credentials_bag_item']`: (default: `"opscenter-dev"`) The databagitem in the `credentials` data bag that contains the credentials for the OpsCenter API.
* `node['opscenter-agent']['opscenter_api_uri']`: (default: `"https://#{node['opscenter-agent']['opscenter-ip']}:8443/`)
* `node['opscenter-agent']['is_opscenter_cluster_configured']`: (default: `false`) Whether or not the Cluster in OpsCenter is already configured.


## Dependencies

* "java", "= 1.24.0"
* "yum", "~> 3.0"
* "limits"
* "line"
* "ohai-nativex" (only for EC2 deployments when using the `determine_ec2_topology` recipe.)

Datastax recommends to use the Oracle JDK. You can do this by setting an attribute in your environment or run list.

## Copyright & License

Some, but not all, of the components of this cookbook are based on the work of Target's DSE cookbook (https://supermarket.getchef.com/cookbooks/dse)

At NativeX:
	- Author: Derek Bromenshenkel (<derek.bromenshenkel@gmail.com>)

