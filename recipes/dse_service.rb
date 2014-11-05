## Cookbook Name:: dse-nativex
## Recipe:: dse_service.rb
##
## Copyright 2014, NativeX
##
## All rights reserved - Do Not Redistribute
##
## Manages the DSE service.

#start DSE
service node['dse']['service_name'] do
  supports :restart => true, :status => true
  action [:enable, :start]
  #if java changes, restart dse
  #subscribes :restart, "java_ark[jdk]"
end