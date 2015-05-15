#
# Cookbook Name:: dse-simplyadrian
# Recipe:: default
#
# Copyright 2014, simplyadrian
#
# All rights reserved - Do Not Redistribute
#
# Default behavior is to install Apache Cassandra DSE component only (with suggested OS configuration), alongside an OpsCenter agent.

include_recipe "dse-simplyadrian::cassandra" #Install the packages & configure cassandra
include_recipe "dse-simplyadrian::jna" #Install JNA
include_recipe "dse-simplyadrian::jemalloc" if node['cassandra']['memory_allocator'] == "JEMallocAllocator" #Install JEMalloc, if necessary
include_recipe "dse-simplyadrian::os_settings" # Configure the OS for Cassandra
include_recipe "dse-simplyadrian::dse_service" # Setup and start the DSE service
include_recipe "dse-simplyadrian::opscenter-agent" if node['opscenter-agent']['enabled'] # Setup OpsCenter, if required.
