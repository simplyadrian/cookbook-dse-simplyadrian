# Default attributes for DataStax Enterprise Server
default['dse']['service_name']                            =  "dse"
default['dse']['conf_dir']                                = "/etc/dse"
# dse.yaml settings
default['dse']['delegated_snitch']                        = "org.apache.cassandra.locator.SimpleSnitch"
default['dse']['cql_slow_log_threshold_ms']               = nil
default['dse']['cql_slow_log_ttl']                        = nil
default['dse']['cql_system_info_options']                 = {"enabled" => false, "refresh_rate_ms" => 10000}
default['dse']['resource_level_latency_tracking_options'] = {"enabled" => false, "refresh_rate_ms" => 10000}
default['dse']['db_summary_stats_options']                = {"enabled" => false, "refresh_rate_ms" => 10000}
default['dse']['cluster_summary_stats_options']           = {"enabled" => false, "refresh_rate_ms" => 10000}
default['dse']['histogram_data_options']                  = {"enabled" => false, "refresh_rate_ms" => 10000, "retention_count" => 3}
default['dse']['histogram_data_options']                  = {"enabled" => false, "refresh_rate_ms" => 10000, "top_stats_limit" => 100}

