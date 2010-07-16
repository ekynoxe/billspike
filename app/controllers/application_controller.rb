class ApplicationController < ActionController::Base
  helper :all
  helper_method :current_user_session, :current_user, :current_share
  protect_from_forgery

# Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation
  
  def filter_units
    params[:item] = filter_units_inputs(params[:item])
  end
  
  def filter_units_inputs(input)
    if [Array, Hash, HashWithIndifferentAccess].include?(input.class)
      input.each do |key, value|
#recurse through the data structure
        input[key] = self.filter_units_inputs(value)
      end
#match the string format for a float with ot without decimals
    elsif not input.nil? and input.match(/^\d+(\.)?(\d+)?$/)
#convert to a minor unit integer
      (input.to_f * 100.0).to_i
    else
#return the value unchanged
      input
    end
  end
  
  private
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end
  
  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to login_url
      return false
    end
  end
  
  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to root_url
      return false
    end
  end
  
  def current_share
    return (params[:share_id].blank? || params[:id].blank?) ? current_user.shares.find(params[:share_id] || params[:id]) : false
  end
  
  def require_share
    unless current_share
      redirect_to root_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
  def mailer_set_url_options
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
end
