require 'sinatra/base'
EMAIL_REGEX = /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/

module Sinatra
	def validation
		@errors << 'Email is not valid'  unless params[:email].match EMAIL_REGEX
  		@errors << 'Text must have 1 letter at least' if params[:text].empty?
	end
helpers Sinatra
end

