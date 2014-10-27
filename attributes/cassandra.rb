#Cassandra Default Info
default['cassandra']['solr']                                        = false
default['cassandra']['hadoop']                                      = false
default['cassandra']['dse_version']                                 = "4.5.2-1"
default['cassandra']['user']                                        = "cassandra"
default['cassandra']['group']                                       = "cassandra"
default['cassandra']['root_dir']                                    = "/var/lib/cassandra/"
default['cassandra']['log_directory']                               = "/var/log/cassandra/"
default['cassandra']['jar_lib_dir']                                 = "/usr/share/dse/cassandra/lib"
default['cassandra']['vnodes']                                      = true
default['cassandra']['datacenter']                                  = "DC1"
default['cassandra']['rack']                                        = "RAC1"
default['cassandra']['num_seeds_per_dc']                            = 3
default['cassandra']['cluster_dc_info']                             = {}
# cassandra.yaml settings (Defaults according to Apache release: https://github.com/apache/cassandra/blob/cassandra-2.0.10/conf/cassandra.yaml)
default['cassandra']['cluster_name']                                = "Test Cluster"
default['cassandra']['auto_bootstrap']                              = true
default['cassandra']['num_tokens']                                  = "256"
default['cassandra']['initial_token']                               = ""
default['cassandra']['hinted_handoff_enabled']                      = true
default['cassandra']['max_hint_window_in_ms']                       = 10800000
default['cassandra']['hinted_handoff_throttle_in_kb']               = 1024
default['cassandra']['max_hints_delivery_threads']                  = 2
default['cassandra']['batchlog_replay_throttle_in_kb']              = 1024
default['cassandra']['authenticator']                               = "AllowAllAuthenticator"
default['cassandra']['authorizer']                                  = "AllowAllAuthorizer"
default['cassandra']['permissions_validity_in_ms']                  = 2000
default['cassandra']['partitioner']                                 = "org.apache.cassandra.dht.Murmur3Partitioner"
default['cassandra']['data_file_directories']                       = [ "/var/lib/cassandra/data" ]
default['cassandra']['commitlog_directory']                         = "/var/lib/cassandra/commitlog"
default['cassandra']['disk_failure_policy']                         = "stop"
default['cassandra']['commit_failure_policy']                       = "stop"
default['cassandra']['key_cache_size_in_mb']                        = ""
default['cassandra']['key_cache_save_period']                       = 14400
default['cassandra']['row_cache_size_in_mb']                        = 0
default['cassandra']['row_cache_save_period']                       = 0
default['cassandra']['memory_allocator']                            = "NativeAllocator"
default['cassandra']['saved_caches_directory']                      = "/var/lib/cassandra/saved_caches"
default['cassandra']['commitlog_sync']                              = "periodic"
default['cassandra']['commitlog_sync_period_in_ms']                 = 10000
default['cassandra']['commitlog_segment_size_in_mb']                = 32
default['cassandra']['seeds']                                       = node['ipaddress']
default['cassandra']['concurrent_reads']                            = 32
default['cassandra']['concurrent_writes']                           = 32
default['cassandra']['memtable_total_space_in_mb']                  = nil
default['cassandra']['memtable_flush_writers']                      = nil
default['cassandra']['memtable_flush_queue_size']                   = 4
default['cassandra']['trickle_fsync']                               = false
default['cassandra']['trickle_fsync_interval_in_kb']                = 10240
default['cassandra']['storage_port']                                = 7000
default['cassandra']['ssl_storage_port']                            = 7001
default['cassandra']['listen_address']                              = node['ipaddress']
default['cassandra']['start_native_transport']                      = true
default['cassandra']['native_transport_port']                       = 9042
default['cassandra']['start_rpc']                                   = true
default['cassandra']['rpc_address']                                 = node['ipaddress']
default['cassandra']['rpc_port']                                    = 9160
default['cassandra']['rpc_keepalive']                               = true
default['cassandra']['rpc_server_type']                             = "sync"
default['cassandra']['rpc_min_threads']                             = nil
default['cassandra']['rpc_max_threads']                             = nil
default['cassandra']['thrift_framed_transport_size_in_mb']          = "15"
default['cassandra']['incremental_backups']                         = false
default['cassandra']['snapshot_before_compaction']                  = false
default['cassandra']['auto_snapshot']                               = true
default['cassandra']['tombstone_warn_threshold']                    = 1000
default['cassandra']['tombstone_failure_threshold']                 = 100000
default['cassandra']['column_index_size_in_kb']                     = 64
default['cassandra']['batch_size_warn_threshold_in_kb']             = 5
default['cassandra']['in_memory_compaction_limit']                  = 64
default['cassandra']['concurrent_compactors']                       = nil
default['cassandra']['multithreaded_compaction']                    = false
default['cassandra']['compaction_throughput_mb_per_sec']            = 16
default['cassandra']['compaction_preheat_key_cache']                = true
default['cassandra']['stream_throughput_outbound_megabits_per_sec'] = nil
default['cassandra']['read_request_timeout_in_ms']                  = 5000
default['cassandra']['range_request_timeout_in_ms']                 = 10000
default['cassandra']['write_request_timeout_in_ms']                 = 2000
default['cassandra']['cas_contention_timeout_in_ms']                = 1000
default['cassandra']['truncate_request_timeout_in_ms']              = 60000
default['cassandra']['request_timeout_in_ms']                       = 10000
default['cassandra']['cross_node_timeout']                          = false
default['cassandra']['endpoint_snitch']                             = "SimpleSnitch"
default['cassandra']['dynamic_snitch_update_interval_in_ms']        = 100
default['cassandra']['dynamic_snitch_reset_interval_in_ms']         = 600000
default['cassandra']['dynamic_snitch_badness_threshold']            = 0.1
default['cassandra']['request_scheduler']                           = "org.apache.cassandra.scheduler.NoScheduler"
default['cassandra']['internode_compression']                       = "all"
default['cassandra']['inter_dc_tcp_nodelay']                        = false
default['cassandra']['preheat_kernel_page_cache']                   = false

#cassandra-env.sh
default['cassandra']['max_heap_size']                               = nil
default['cassandra']['heap_newsize']                                = nil
default['cassandra']['jvm_gc_SurvivorRatio']                        = 8
default['cassandra']['jvm_gc_MaxTenuringThreshold']                 = 1
default['cassandra']['jvm_gc_CMSInitiatingOccupancyFraction']       = "75"
default['cassandra']['jvm_gc_UseNUMA']                              = false
default['cassandra']['gc_log_PrintGCDetails']                       = false
default['cassandra']['gc_log_PrintGCDateStamps']                    = false
default['cassandra']['gc_log_PrintHeapAtGC']                        = false
default['cassandra']['gc_log_PrintTenuringDistribution']            = false
default['cassandra']['gc_log_PrintGCApplicationStoppedTime']        = false
default['cassandra']['gc_log_PrintPromotionFailure']                = false
default['cassandra']['gc_log_PrintFLSStatistics']                   = false
default['cassandra']['gc_log_PrintSafepointStatistics']             = false
default['cassandra']['gc_log_PrintSafepointStatisticsCount']        = false
default['cassandra']['gc_log_TraceBiasedLocking']                   = false
default['cassandra']['gc_log_Xloggc']                               = nil
default['cassandra']['gc_log_UseGCLogFileRotation']                 = false
default['cassandra']['gc_log_NumberOfGCLogFiles']                   = nil
default['cassandra']['gc_log_GCLogFileSize']                        = nil

# Log4J Settings
default['cassandra']['log_level']                                   = "INFO"
default['cassandra']['log_file_size_mb']                            = "20"
default['cassandra']['log_file_roll_count']                         = 10
default['cassandra']['log_syslog_enabled']                          = false
default['cassandra']['log_syslog_host']                             = ""
default['cassandra']['log_syslog_threshold']                        = "WARN"
default['cassandra']['audit_logging']                               = false
default['cassandra']['audit_dir']                                   = "/etc/dse/cassandra"
default['cassandra']['active_categories']                           = "ADMIN,AUTH,DDL,DCL"

# JNA (3.2.7 or higher required for C* 2.0 and 2.1)
default['cassandra']['jna_version']                                 = "3.5.2"
default['cassandra']['jna_install_dir']                             = node['cassandra']['jar_lib_dir']
default['cassandra']['jna_jar_source_base_uri']                     = "https://maven.java.net/content/repositories/releases/net/java/dev/jna/jna/"

# JEMalloc
default['cassandra']['jemalloc_location']                           = "/usr/lib64/"

# OS settings for Cassandra (See: http://www.datastax.com/documentation/cassandra/2.0/cassandra/install/installRecommendSettings.html)
default['cassandra']['os']['zone_reclaim_mode']                     = 0
default['cassandra']['os']['limits_ary']                            = [
                                                                       { 'domain' => 'cassandra', 'type' => '-', 'item' => 'memlock', 'value' => 'unlimited' },
                                                                       { 'domain' => 'cassandra', 'type' => '-', 'item' => 'nofile', 'value' => '100000' },
                                                                       { 'domain' => 'cassandra', 'type' => '-', 'item' => 'nproc', 'value' => '32768' },
                                                                       { 'domain' => 'cassandra', 'type' => '-', 'item' => 'as', 'value' => 'unlimited' }
                                                                      ]
default['cassandra']['os']['90_nproc_limits_ary']                   = [
                                                                       { 'domain' => 'root', 'type' => 'soft', 'item' => 'nproc', 'value' => 'unlimited' },
                                                                       { 'domain' => '*', 'type' => '-', 'item' => 'nproc', 'value' => '32768' }
                                                                      ]
default['cassandra']['os']['sysctl_vm_max_map_count']               = 131072