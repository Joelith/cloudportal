class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit

	if Rails.env.development? or Rails.env.testing? then
		Fog.mock!
		puts "Fog: #{Fog::Mock.delay}"
		Fog::Mock.delay = 5
	end
end
