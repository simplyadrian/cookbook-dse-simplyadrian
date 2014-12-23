#This recipe sets up the yum repos, directories, tuning settings, and installs the dse package.
#Install java
include_recipe "java" if node['dse']['manage_java']

#create the data directories for Cassandra
 node['cassandra']['data_file_directories'].each do |dir|
  directory dir do
   owner node['cassandra']['user']
   group node['cassandra']['group']
   mode "775"
   recursive true
   action :create
  end
end

#Make sure the commit directory exists (in case we changed it from default)
 directory node['cassandra']['commitlog_directory'] do
   owner node['cassandra']['user']
   group node['cassandra']['group']
   mode "755"
   recursive true
   action :create
  end

#Make sure the saved_caches directory exists (in case we changed it from default, OR it disappeared from the ephemeral nature of EC2 ssds after stop/start.)
 directory node['cassandra']['saved_caches_directory'] do
   owner node['cassandra']['user']
   group node['cassandra']['group']
   mode "755"
   recursive true
   action :create
  end

#install the dse-full package
case node['platform']
#make sure not to overwrite any conf files on upgrade
when "redhat", "centos", "fedora", "scientific", "amazon"
  package "dse-full" do
    version node['cassandra']['dse_version']
    options "--nogpgcheck"
    action :install
  end
else
  Chef::Log.warn("Unsupported platform!")
end
