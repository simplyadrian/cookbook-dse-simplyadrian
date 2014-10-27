#
## Cookbook Name:: dse-nativex
## Recipe:: os_settings.rb
##
## Copyright 2014, NativeX
##
## All rights reserved - Do Not Redistribute
##
## Configures OS limits and other OS-specific settings

# creates /etc/security/limits.d/cassandra.conf
limits_config 'cassandra' do
  limits node['cassandra']['os']['limits_ary']
  action :create
end

# creates /etc/security/limits.d/90-nproc.conf
limits_config '90-nproc' do
  limits node['cassandra']['os']['90_nproc_limits_ary']
  action :create
end

# Sets up zone_reclaim_mode file.  See http://www.datastax.com/documentation/cassandra/2.0/cassandra/install/installRecommendSettings.html?scroll=reference_ds_sxl_gf3_2k__zone-reclaim-mode
template "/proc/sys/vm/zone_reclaim_mode" do
  source "zone_reclaim_mode.erb"
  owner "root"
  group "root"
end