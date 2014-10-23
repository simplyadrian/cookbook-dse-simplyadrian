#
## Cookbook Name:: dse-nativex
## Recipe:: jemalloc.rb
##
## Copyright 2014, NativeX
##
## All rights reserved - Do Not Redistribute
##
## Installs the JEMalloc package/library on the system to make it available as one of the Off-heap memory allocators

package "jemalloc" do
  action :install
end
