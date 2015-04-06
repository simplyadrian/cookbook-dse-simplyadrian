module DseNativexHelper
  def self.isFirstSeed( theNode )
    if theNode.has_key?("cassandra") && theNode["cassandra"].has_key?("seeds") && theNode["cassandra"]["seeds"].length > 0
      # check whether this node's ip address is the first in the comma-separated list of seeds.
      return theNode["ipaddress"] == theNode["cassandra"]["seeds"].split(",")[0]
    end
    return false
  end
end
