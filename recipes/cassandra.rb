#Include the setup recipe for DataStax
include_recipe "dse-nativex::datastax"

#set up the dse default file. This sets up hadoop, etc
template "/etc/default/dse" do
  source "dse.erb"
  owner node['cassandra']['user']
  group node['cassandra']['group']
  #notifies :restart, "service[#{node['cassandra']['dse']['service_name']}]"
end

#set up log 4j template (audit logs, etc)
template "#{node['cassandra']['audit_dir']}/log4j-server.properties" do
  source "log4j-server.properties.erb"
  owner node['cassandra']['user']
  group node['cassandra']['group']
  #notifies :restart, "service[#{node['cassandra']['dse']['service_name']}]"
end

#set up the dse.yaml template for dse
template "#{node['dse']['conf_dir']}/dse.yaml" do
  source "dse.yaml.erb"
  owner node['cassandra']['user']
  group node['cassandra']['group']
  #notifies :restart, "service[#{node['cassandra']['dse']['service_name']}]"
end

#set up cassandra.yaml template (contains almost all Cassandra tuning properties)
template "#{node['dse']['conf_dir']}/cassandra/cassandra.yaml" do
  source "cassandra.yaml.erb"
  owner node['cassandra']['user']
  group node['cassandra']['group']
  #notifies :restart, "service[#{node['cassandra']['dse']['service_name']}]"
end

#set up the cassandra-env.sh template (this contains JVM settings)
template "#{node['dse']['conf_dir']}/cassandra/cassandra-env.sh" do
  source "cassandra-env.sh.erb"
  owner node['cassandra']['user']
  group node['cassandra']['group']
  #notifies :restart, "service[#{node['cassandra']['dse']['service_name']}]"
end

#check what kind of snitch is set, since it requires different templates.
case node['dse']['delegated_snitch']
  #GossipingPropertyFile
  when "org.apache.cassandra.locator.GossipingPropertyFileSnitch"
  template "#{node['dse']['conf_dir']}/cassandra/cassandra-rackdc.properties" do
    source "cassandra-rackdc.properties.erb"
    owner node['cassandra']['user']
    group node['cassandra']['group']
    #notifies :restart, "service[#{node['cassandra']['dse']['service_name']}]"
    end
  else
    Chef::Log.warn("Unsupported Snitch!!")
  end
