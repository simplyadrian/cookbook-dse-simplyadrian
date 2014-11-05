#
# Cookbook Name:: dse-nativex
# Recipe:: default
#
# Copyright 2014, NativeX
#
# All rights reserved - Do Not Redistribute
#
# Default behavior is to install Apache Cassandra DSE component only (with suggested OS configuration), alongside an OpsCenter agent.

include_recipe "dse-nativex::cassandra" #Install the packages & configure cassandra
include_recipe "dse-nativex::jna" #Install JNA
include_recipe "dse-nativex::jemalloc" if node['cassandra']['memory_allocator'] == "JEMallocAllocator" #Install JEMalloc, if necessary
include_recipe "dse-nativex::os_settings" # Configure the OS for Cassandra
include_recipe "dse-nativex::dse_service" # Setup and start the DSE service
include_recipe "dse-nativex::opscenter-agent" if node['opscenter-agent']['enabled'] # Setup OpsCenter, if required.
