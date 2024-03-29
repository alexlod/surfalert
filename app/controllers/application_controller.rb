class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :setup_current_user
  
  attr_reader :current_user
  helper_method :current_user, :user_logged_in?
  
  def user_logged_in?
    ! @current_user.nil?
  end
  
  protected
  
    # sets up the `current_user` variable from the session.
    def setup_current_user
      @current_user = User.find(session[:user_id]) unless session[:user_id].nil?
    end
    
    # Redirects a user to the login path if they aren't logged in.
    def requires_login
      unless user_logged_in?
        return redirect_to login_index_path, notice: "You must login to view that page."
      end
    end
end
