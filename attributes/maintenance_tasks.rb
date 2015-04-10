default['dse-nativex']['activitytracking_keep_weeks']                = 2 #current + 1
default['dse-nativex']['cron_activitytracking_drop_enabled']         = false
default['dse-nativex']['cron_activitytracking_drop_minute']          = '0'
default['dse-nativex']['cron_activitytracking_drop_hour']            = '9'
default['dse-nativex']['cron_activitytracking_drop_day']             = '*'
default['dse-nativex']['cron_activitytracking_drop_month']           = '*'
default['dse-nativex']['cron_activitytracking_drop_weekday']         = '1'
default['dse-nativex']['cron_activitytracking_file_cleanup_enabled'] = node['dse-nativex']['cron_activitytracking_drop_enabled'] # don't cleanup unless Drop happens as well
default['dse-nativex']['cron_activitytracking_file_cleanup_minute']  = '30'
default['dse-nativex']['cron_activitytracking_file_cleanup_hour']    = '9'
default['dse-nativex']['cron_activitytracking_file_cleanup_day']     = '*'
default['dse-nativex']['cron_activitytracking_file_cleanup_month']   = '*'
default['dse-nativex']['cron_activitytracking_file_cleanup_weekday'] = '1'
default['dse-nativex']['cron_cluster_repair_enabled']                = false
default['dse-nativex']['cron_cluster_repair_minute']                 = '0'
default['dse-nativex']['cron_cluster_repair_hour']                   = '0'
default['dse-nativex']['cron_cluster_repair_day']                    = '*'
default['dse-nativex']['cron_cluster_repair_month']                  = '*'
default['dse-nativex']['cron_cluster_repair_weekday']                = 'auto'
default['dse-nativex']['cron_cluster_repair_mobile_tables']          = [ "Device", "DeviceActivityHistory", "DeviceIncentiveHistory",
                                                                         "DeviceUDID", "DeviceUDID_IDX_DeviceId", "OfferConversionDayAggregate",
                                                                         "OfferConversionHourAggregate", "OfferConversionMonthAggregate",
                                                                         "OfferConversionUnaggregated", "PaymentReceipt" ]
default['dse-nativex']['cron_take_snapshot_enabled']                 = false
default['dse-nativex']['cron_take_snapshot_minute']                  = '45'
default['dse-nativex']['cron_take_snapshot_hour']                    = '9'
default['dse-nativex']['cron_take_snapshot_day']                     = '*'
default['dse-nativex']['cron_take_snapshot_month']                   = '*'
default['dse-nativex']['cron_take_snapshot_weekday']                 = '1'
default['dse-nativex']['cron_clear_snapshot_enabled']                = false
default['dse-nativex']['cron_clear_snapshot_minute']                 = '15'
default['dse-nativex']['cron_clear_snapshot_hour']                   = '9'
default['dse-nativex']['cron_clear_snapshot_day']                    = '*'
default['dse-nativex']['cron_clear_snapshot_month']                  = '*'
default['dse-nativex']['cron_clear_snapshot_weekday']                = '0,1,3-6'
default['dse-nativex']['maint_task_emails']                          = 'root.linux@nativex.com,corey.hemminger@nativex.com,derek.bromenshenkel@nativex.com'