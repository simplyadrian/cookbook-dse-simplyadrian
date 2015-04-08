#
# Cookbook Name:: dse-nativex
# Recipe:: maintenance_tasks
#
# Copyright (C) 2015 NativeX
#
# All rights reserved - Do Not Redistribute
#
# Sets up scheduled maintenance tasks (cluster repair, ActivityTracking CF drop, ActivityTracking data files cleanup, backups) using 'cron'

directory '/root/cassandrascripts' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

if DseNativexHelper.canDetermineRepairWeekday?(node)
  # Schedule cluster repair. 
  # In "auto" mode, do this "safely" by scheduling one Cassandra Rack (== "availability zone" in EC2) per day.
  # Otherwise the user can override the "weekday" attribute.
  cron "Cassandra Cluster Repair" do
    action node['dse-nativex']['cron_cluster_repair_enabled'] ? :create : :delete
    minute node['dse-nativex']['cron_cluster_repair_minute']
    hour node['dse-nativex']['cron_cluster_repair_hour']
    day node['dse-nativex']['cron_cluster_repair_day']
    month node['dse-nativex']['cron_cluster_repair_month']
    weekday { DseNativexHelper.determineRepairWeekday(node) }
    command "/root/cassandrascripts/localClusterRepair.sh"
  end
else
  # If we can't reliably determine the schedule, then delete the cron task even if repair is enabled.
  cron "Cassandra Cluster Repair" do
    action :delete
  end
  
  log "Log Repair disablement" do
    level :warn
    message "Disabling the cron task for cluster repair even though it is enabled, because the Weekday cannot be determined!"
    only_if node['dse-nativex']['cron_cluster_repair_enabled']
  end
end

template "Cassandra Script 'localClusterRepair.sh'" do
  source "cassandrascripts/localClusterRepair.sh.erb"
  path "/root/cassandrascripts/localClusterRepair.sh"
  group 'root'
  owner 'root'
  mode '0755'
  action node['dse-nativex']['cron_cluster_repair_enabled'] ? :create : :delete
end
  
# We only want to do this on one node in the entire cluster. A way to ensure consistent singularity 
# is to check if the current node is the "first" seed node, and only create the drop script there.
template "Cassandra Script 'ActivityTrackingDropCF.sh'" do
  source "cassandrascripts/ActivityTrackingDropCF.sh.erb"
  path "/root/cassandrascripts/ActivityTrackingDropCF.sh"
  group 'root'
  owner 'root'
  mode '0755'
  action ( node['dse-nativex']['cron_activitytracking_drop_enabled'] && DseNativexHelper.isFirstSeed?(node) ) ? :create : :delete
end

# We only want to do this on one node in the entire cluster. A way to ensure consistent singularity 
# is to check if the current node is the "first" seed node, and only enable the task there.
cron "Cassandra ActivityTracking CF Drop" do
  action ( node['dse-nativex']['cron_activitytracking_drop_enabled'] && DseNativexHelper.isFirstSeed?(node) ) ? :create : :delete
  minute node['dse-nativex']['cron_activitytracking_drop_minute']
  hour node['dse-nativex']['cron_activitytracking_drop_hour']
  day node['dse-nativex']['cron_activitytracking_drop_day']
  month node['dse-nativex']['cron_activitytracking_drop_month']
  weekday node['dse-nativex']['cron_activitytracking_drop_weekday']
  command "/root/cassandrascripts/ActivityTrackingDropCF.sh #{node['dse-nativex']['activitytracking_keep_weeks'] * 7}"
end

template "Cassandra Script 'removeWeeklyActivityTrackingCFfiles.sh'" do
  source "cassandrascripts/removeWeeklyActivityTrackingCFfiles.sh.erb"
  path "/root/cassandrascripts/removeWeeklyActivityTrackingCFfiles.sh"
  group 'root'
  owner 'root'
  mode '0755'
  action node['dse-nativex']['cron_activitytracking_file_cleanup_enabled'] ? :create : :delete
end

cron "Cassandra ActivityTracking Remove Files" do
  action node['dse-nativex']['cron_activitytracking_file_cleanup_enabled'] ? :create : :delete
  minute node['dse-nativex']['cron_activitytracking_file_cleanup_minute']
  hour node['dse-nativex']['cron_activitytracking_file_cleanup_hour']
  day node['dse-nativex']['cron_activitytracking_file_cleanup_day']
  month node['dse-nativex']['cron_activitytracking_file_cleanup_month']
  weekday node['dse-nativex']['cron_activitytracking_file_cleanup_weekday']
  command "/root/cassandrascripts/removeWeeklyActivityTrackingCFfiles.sh #{node['dse-nativex']['activitytracking_keep_weeks'] * 7}"
end

cron "Cassandra Take Snapshot" do
  action node['dse-nativex']['cron_take_snapshot_enabled'] ? :create : :delete
  minute node['dse-nativex']['cron_take_snapshot_minute']
  hour node['dse-nativex']['cron_take_snapshot_hour']
  day node['dse-nativex']['cron_take_snapshot_day']
  month node['dse-nativex']['cron_take_snapshot_month']
  weekday node['dse-nativex']['cron_take_snapshot_weekday']
  command '/usr/bin/nodetool -h localhost snapshot'
end

cron "Cassandra Clear Snapshot" do
  action node['dse-nativex']['cron_clear_snapshot_enabled'] ? :create : :delete
  minute node['dse-nativex']['cron_clear_snapshot_minute']
  hour node['dse-nativex']['cron_clear_snapshot_hour']
  day node['dse-nativex']['cron_clear_snapshot_day']
  month node['dse-nativex']['cron_clear_snapshot_month']
  weekday node['dse-nativex']['cron_clear_snapshot_weekday']
  command '/usr/bin/nodetool -h localhost clearsnapshot'
end
