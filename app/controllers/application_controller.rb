class ApplicationController < ActionController::Base
  before_action :require_user
  
  helper_method :current_user

  # Define the current_user method:
  def current_user
    # Look up the current user based on user_id in the access_token cookie:
    @current_user ||= current_access_token.try(:user)
  end

  def current_access_token
    @current_access_token ||= AccessToken.active.joins(:user).lock.find_by(token: cookies[:access_token])
  end

  def require_user
    if current_user.nil?
      cookies[:continue_to] = request.fullpath
      redirect_to root_path, alert: 'You must be logged in to access this page.'
    end
  end

end
