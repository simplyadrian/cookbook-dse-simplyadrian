#
## Cookbook Name:: nativex-dse
## Recipe:: determine_ec2_topology.rb
##
## Copyright 2014, NativeX
##
## All rights reserved - Do Not Redistribute
##
include_recipe "nativex-ohai::default"

ruby_block "determine_ec2_toplogy_properties" do
  block do
    if node['cloud']['provider'] == 'ec2'
      if node['aws']['region']
        node.set['cassandra']['datacenter'] = node['aws']['region']

        if node['ec2']['placement_availability_zone']
          node.set['cassandra']['rack'] = node['ec2']['placement_availability_zone']
        else
          Chef::Log.warn("Undefined AWS availability zone! Cannot automatically determine cluster topology.")
        end
      else
        Chef::Log.warn("Undefined AWS region! Cannot automatically determine cluster topology.")
      end
    else
      Chef::Log.warn("Unsupported provider #{node['cloud']['provider']}. Cannot automatically determine cluster topology.")
    end
  end
  action :run
end
