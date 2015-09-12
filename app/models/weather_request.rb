class WeatherRequest
	# basic class to store methods to get weather requests.

	def initialize
  		# weather_hash = fetch_weather(zipcode)
  		# assign_values(weather_hash)
	end

	def fetch_weather(user_zipcode)
		if user_zipcode.nil? 
			user_zipcode = "autoip"
		end
		
		api_key = Rails.application.secrets[:wunderground_key]
		base_request = "http://api.wunderground.com/api/#{api_key}/"
    	JSON.parse(HTTParty.get("#{base_request}/hourly/q/#{user_zipcode}.json").body)
	end
end