class ApplicationController < ActionController::Base
  
  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def ensure_logged_in
  	unless current_user
  		flash[:alert] = "Please Log In!"
  		redirect_to new_session_path
  	end
  end
end
