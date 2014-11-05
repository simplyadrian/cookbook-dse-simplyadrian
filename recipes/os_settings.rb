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

# Uses provider in 'line' cookbook to make sure the vm.max_map_count line exists, and is set to the proper value.
replace_or_add "sysctl vm.max_map_count line" do
  path "/etc/sysctl.conf"
  pattern "^vm\.max_map_count.*"
  line "vm.max_map_count = #{node['cassandra']['os']['sysctl_vm_max_map_count']}"
  notifies :run, "execute[update-runtime-sysctl]", :immediately
end

execute "turn off swap" do
  command "swapoff --all"
  timeout 10
  only_if "if [[ \"$(swapon -s | wc -l)\" -ge 2 ]]; then $(exit 0); else $(exit 1); fi" # check if swap is on.  First line is always a header
  action :run
end

# At runtime, updates the kernel parameters.  -p with no parameter says to load /etc/sysctl.conf -e to skip errors on unknown keys - there are some in the default config
execute "update-runtime-sysctl" do
  command "sysctl -e -p"
  action :nothing
end
