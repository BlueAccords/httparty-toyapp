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
			puts "TESTINGU"
			@response = 
				HTTParty.get("#{base_uri}t=#{title}&y=&plot=short&r=json")
				# this line below works.
				# HTTParty.get("http://www.omdbapi.com/?t=kingsman&y=&plot=short&r=json")

			puts @response
		end
  end
end
