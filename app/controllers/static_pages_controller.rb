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
        # HTTParty.get("http://www.omdbapi.com/?t=kingsman&y=&plot=short&r=json")
    end
  end

  def reddit
    base_uri = "http://reddit.com/"
    username = params[:username]
      @response = HTTParty.get("#{base_uri}user/IriFlina/comments.json")

      data = JSON.parse(@response.body)

      data['data']['children'].each do |child|
        puts child['data']['body']
      end
  end
end
