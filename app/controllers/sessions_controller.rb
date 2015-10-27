class SessionsController < ApplicationController
	def new

		@vk_url = VkontakteApi.authorization_url(scope: [:friends, :groups, :offline, :notify], state: session[:state])
	end

end
