class Ahoy::Store < Ahoy::DatabaseStore
  def exclude?
    bot? || request.ip == "192.168.1.1"
  end
end



# set to true for JavaScript tracking
Ahoy.api = false
 # better user agent parsing
Ahoy.user_agent_parser = :device_detector
 # Get the bots and know when they index you...
Ahoy.track_bots = true 
# Move geocode to background for better performance 
Ahoy.geocode = :async
Ahoy.job_queue = :low_priority

