module DseSimplyadrianHelper
  @@availabilityZoneAlphas = ("a".."g").to_a
  @@rackDigits = (1..7).to_a

  def self.isFirstSeed?( theNode )
    if theNode.has_key?("cassandra") && theNode["cassandra"].has_key?("seeds") && theNode["cassandra"]["seeds"].length > 0
      # check whether this node's ip address is the first in the comma-separated list of seeds.
      return theNode["ipaddress"] == theNode["cassandra"]["seeds"].split(",")[0]
    end
    return false
  end

  def self.canDetermineRepairWeekday?( theNode )
    if theNode['dse-simplyadrian']['cron_cluster_repair_weekday'].downcase == "auto"
      # If 'auto' then we try to map the last digit in the "rack" property to
      # either a set of letters (representing an EC2 availability zone, for example)
      # or a set of integers
      return theNode.has_key?("cassandra") &&
             theNode["cassandra"].has_key?("rack") &&
             ( @@availabilityZoneAlphas.include?(theNode["cassandra"]["rack"][-1]) ||
               @@rackDigits.include?(theNode["cassandra"]["rack"][-1]) )
    else
      # Otherwise we can just use whatever the user has set the property to be.
      return true
    end
  end
  
  def self.determineRepairWeekday( theNode )
    if theNode['dse-simplyadrian']['cron_cluster_repair_weekday'].downcase == "auto"
      # If 'auto' then we try to map the last digit in the "rack" property to
      # either a set of letters (representing an EC2 availability zone, for example)
      # or a set of integers
      if @@availabilityZoneAlphas.include?(theNode["cassandra"]["rack"][-1])
        return (@@availabilityZoneAlphas.index(theNode["cassandra"]["rack"][-1]) + 1) % 7
      elsif @@rackDigits.include?(theNode["cassandra"]["rack"][-1])
        return (@@rackDigits.index(theNode["cassandra"]["rack"][-1]) + 1) % 7
      else
        raise "Could not automatically determine the Repair weekday from node['cassandra']['rack'] value of '#{theNode['cassandra']['rack']}'"
      end
    else
      # Otherwise we just use whatever the user has set the property to be.
      return theNode['dse-simplyadrian']['cron_cluster_repair_weekday']
    end
  end
end
