#
## Cookbook Name:: dse-nativex
## Recipe:: jna.rb
##
## Copyright 2014, NativeX
##
## All rights reserved - Do Not Redistribute
##
## Installs the JNA library on the system
## See: http://www.datastax.com/documentation/cassandra/2.0/cassandra/install/installJnaTar.html

jna_jar_name = "jna-#{node['cassandra']['jna_version']}.jar"
jna_install_path = "#{node['cassandra']['jna_install_dir']}/#{jna_jar_name}"
jna_source_url = "#{node['cassandra']['jna_jar_source_base_uri']}#{node['cassandra']['jna_version']}/#{jna_jar_name}"

remote_file "jna jar" do
  path jna_install_path
  source jna_source_url
  owner node['cassandra']['user']
  group node['cassandra']['group']
  mode '0755'
  action :create_if_missing
  not_if { ::File.exists?(jna_install_path) }
end
