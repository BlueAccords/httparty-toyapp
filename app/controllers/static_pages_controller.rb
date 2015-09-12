class StaticPagesController < ApplicationController

  def home
  	client_id= Rails.application.secrets[:soundcloud_client_key]
	secret_id= Rails.application.secrets[:soundcloud_secret_key]
  	base_uri = "http://api.soundcloud.com"
  	@response = 
  		HTTParty.get("#{base_uri}/users/2876232?client_id=#{client_id}")

  end

  def omdb
  	base_uri = "http://www.omdbapi.com/?"
  	title = params[:title]
  	year  = params[:year]
		if !title.nil?
			@response = 
				HTTParty.get("#{base_uri}t=#{title}&y=&plot=short&r=json")
				# this line below works.
				# HTTParty.get("http://www.omdbapi.com/?t=kingsman&y=&plot=short&r=json")

			puts @response
		end
  end

  def mal
    base_uri = "http://myanimelist.net/api/"
    # auth = {:username => "mal name here", :password => "mal pw here"}
    title = params[:title]
    if !title.nil?
      @response = 
        HTTParty.get("#{base_uri}anime/search.json?q=#{title}", :basic_auth => auth)
        # this line below works.
    end
  end

  def reddit
    base_uri = "http://reddit.com/"
    username = params[:username]
    if !username.nil?
      @response = HTTParty.get("#{base_uri}user/#{username}/comments.json")

      @return = create_collection(JSON.parse(@response.body))
      
      # data['data']['children'].each do |child|
      #   puts child['data']['body']
      # end
    end
  end

  def create_collection(data)
    return_arr = []
    data['data']['children'].each do |child|
        temp_hash = {}
        temp_hash['title']             = child['data']['link_title']
        temp_hash['link_author']       = child['data']['link_author']
        temp_hash['body']              = child['data']['body']
        temp_hash['author']            = child['data']['author']
        temp_hash['subreddit']         = child['data']['subreddit']
      return_arr.push(temp_hash)
    end
    return return_arr
  end

  def weather 
    @zipcode = params[:zipcode]
    if !@zipcode.nil? 
      @weather_lookup = WeatherRequest.new
      @weather_lookup = weather_collection(
                        @weather_lookup.fetch_weather(@zipcode))
     # @return = create_collection_w(@weather_lookup)
    end
  end

  def weather_collection(data)
    return_arr = []
    data['hourly_forecast'].each do |child|
        temp_hash = {}
        temp_hash['temperature']             = child['temp']['english']
        temp_hash['icon_url']                = child['icon_url']        
        return_arr.push(temp_hash)
    end
    return return_arr
  end


end
