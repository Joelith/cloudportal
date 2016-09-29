class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit

	if Rails.env.development? then
		Fog.mock!
	end
end
