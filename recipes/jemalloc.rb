#
## Cookbook Name:: dse-simplyadrian
## Recipe:: jemalloc.rb
##
## Copyright 2014, simplyadrian
##
## All rights reserved - Do Not Redistribute
##
## Installs the JEMalloc package/library on the system to make it available as one of the Off-heap memory allocators

package "jemalloc" do
  action :install
end
