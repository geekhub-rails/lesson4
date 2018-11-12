class ApplicationController < ActionController::Base

  def require_user
    redirect_to new_session_path unless current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
