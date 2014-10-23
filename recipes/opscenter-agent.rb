#Install the datastax-agent package
package "datastax-agent" do
  version node['opscenter-agent']['version']
  action :install
end

#Set up the stomp IP (the IP of Opscenter)
template "#{node['opscenter-agent']['conf_dir']}/address.yaml" do
   source "address.yaml.erb"
   notifies :restart, "service[datastax-agent]"
 end

# Make sure the cluster exists in OpsCenter.  Create it if it does not.
ruby_block "opscenter-cluster-existence" do
  block do
    require 'net/http'
    require 'openssl'
    require 'json'
    
    ops_creds = Chef::EncryptedDataBagItem.load("credentials", "#{node['opscenter-agent']['opscenter_credentials_bag_item']}")
    
    uri = URI("#{node['opscenter-agent']['opscenter_api_uri']}cluster-configs")
    Chef::Log.debug("OpsCenter API URL: #{uri}.")
  
    req = Net::HTTP::Get.new(uri.path)
    req.basic_auth "#{ops_creds['opsc_username']}", "#{ops_creds['opsc_password']}"
  
    res = Net::HTTP.start(uri.hostname, uri.port, {use_ssl: uri.scheme == 'https', verify_mode: OpenSSL::SSL::VERIFY_NONE}) {|http|
      http.request(req)
    }
	if res != nil && (res.kind_of?(Net::HTTPSuccess) || res.kind_of?(Net::HTTPOK))
      current_clusters = JSON.parse(res.body)
      
      @normalized_cluster_name = node['cassandra']['cluster_name'].gsub(/[ -]/, '_') #OpsCenter doesn't like spaces and dashes...Nasty trick they do and convert to underscore
      if !current_clusters.keys.include?(@normalized_cluster_name)
        Chef::Log.info("Adding new cluster '#{node['cassandra']['cluster_name']}' using name '#{@normalized_cluster_name}' to OpsCenter.")
        @payload = { "cassandra" => { "seed_hosts" => node['cassandra']['seeds'] }, "jmx" => { "port" => "7199" } }.to_json
        put_req = Net::HTTP::Post.new(uri.path)
        put_req.body = @payload
        put_req.basic_auth "#{ops_creds['opsc_username']}", "#{ops_creds['opsc_password']}"
        put_res = Net::HTTP.start(uri.hostname, uri.port, {use_ssl: uri.scheme == 'https', verify_mode: OpenSSL::SSL::VERIFY_NONE}) {|http|
          http.request(put_req)
        }
        if put_res != nil && (put_res.kind_of?(Net::HTTPSuccess) || put_res.kind_of?(Net::HTTPOK))
          node.set['opscenter-agent']['is_opscenter_cluster_configured'] = true
        else
          Chef::Log.warn("Got a non-successful response from OpsCenter while adding cluster! StatusCode: #{put_res.code}; Message: #{put_res.message}")
        end
      else
        Chef::Log.debug("Cluster #{node['cassandra']['cluster_name']} already exists in OpsCenter.")
        node.set['opscenter-agent']['is_opscenter_cluster_configured'] = true # no need to keep running this code
      end
    else
      Chef::Log.warn("Got a non-successful response from OpsCenter while querying cluster configuration! StatusCode: #{res.code}; Message: #{res.message}")
    end
  end
  not_if { node['opscenter-agent']['is_opscenter_cluster_configured'] }
  action :run
end

#Restart the agent
service "datastax-agent" do
  supports :restart => true, :status => true
  action [:enable, :start]
end
