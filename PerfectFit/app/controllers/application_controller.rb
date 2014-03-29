class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

	def current_user
	  @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
	  #@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
	helper_method :current_user


	def current_name
		@current_name ||= current_user.profile.first_name if cookies[:auth_token]
	end
	helper_method :current_name

	def display_range
		@display_range = :display_time
	end
	helper_method :display_range

	def user_age
		now = Time.now.utc.to_date
		@user_age = now.year - current_user.profile.birthday.year - (current_user.profile.birthday.to_date.change(:year => now.year) > now ? 1 : 0)
	end

	helper_method :user_age

	def authorize
	  redirect_to login_url, alert: "Not authorized" if current_user.nil?
	end
end
