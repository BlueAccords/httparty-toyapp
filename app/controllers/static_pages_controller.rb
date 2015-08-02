class StaticPagesController < ApplicationController

  def home
  	client_id= Rails.application.secrets[:soundcloud_client_key]
	secret_id= Rails.application.secrets[:soundcloud_secret_key]
  	base_uri = "http://api.soundcloud.com"
  	@response = 
  		HTTParty.get("#{base_uri}/users/2876232?client_id=#{client_id}")

  end
end
