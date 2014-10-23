default['opscenter-agent']['enabled']	                       = false 
default['opscenter-agent']['version']                          = "5.0.1-1"
default['opscenter-agent']['conf_dir']	                       = "/var/lib/datastax-agent/conf"
default['opscenter-agent']['opscenter-ip']                     = "127.0.0.1"
default['opscenter-agent']['opscenter_credentials_bag_item']   = "opscenter-dev"
default['opscenter-agent']['opscenter_api_uri']                = "https://#{node['opscenter-agent']['opscenter-ip']}:8443/"
default['opscenter-agent']['is_opscenter_cluster_configured']  = false
