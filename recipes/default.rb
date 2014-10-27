#
# Cookbook Name:: dse-nativex
# Recipe:: default
#
# Copyright 2014, NativeX
#
# All rights reserved - Do Not Redistribute
#
# Default behavior is to install Apache Cassandra DSE component only (with suggested OS configuration), alongside an OpsCenter agent.

include_recipe "dse-nativex::jna"
include_recipe "dse-nativex::jemalloc" if node['cassandra']['memory_allocator'] == "JEMallocAllocator"
include_recipe "dse-nativex::os_settings"
include_recipe "dse-nativex::cassandra"
include_recipe "dse-nativex::opscenter-agent" if node['opscenter-agent']['enabled']
