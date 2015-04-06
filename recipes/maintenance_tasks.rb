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

## TODO: Repair scheduling

## TODO: Template for ActivityTracking CF drop.

# We only want to do this on one node in the entire cluster. A way to ensure consistent singularity 
# is to check if the current node is the "first" seed node, and only enable the task there.
cron "Cassandra ActivityTracking CF Drop" do
  action ( node['dse-nativex']['cron_activitytracking_drop_enabled'] && DseNativexHelper.isFirstSeed(node) ) ? :create : :delete
  minute node['dse-nativex']['cron_activitytracking_drop_minute']
  hour node['dse-nativex']['cron_activitytracking_drop_hour']
  day node['dse-nativex']['cron_activitytracking_drop_day']
  month node['dse-nativex']['cron_activitytracking_drop_month']
  weekday node['dse-nativex']['cron_activitytracking_drop_weekday']
  command "/root/cassandrascripts/ActivityTrackingDropCF.sh #{node['dse-nativex']['activitytracking_keep_weeks'] * 7}"
end

cookbook_file "Cassandra Script 'removeWeeklyActivityTrackingCFfiles.sh'" do
  source "cassandrascripts/removeWeeklyActivityTrackingCFfiles.sh"
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
