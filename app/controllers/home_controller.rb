class HomeController < ApplicationController
  #before_filter :require_user
  before_filter :store_location
  
  def index
    if current_user
      @shares   = current_user.shares.all
      @invites  = Invite.find(:all, :order=>:sent_at, :conditions=>conditions = ["recipient_email=?", "#{current_user.email}"])
    else
      @user_session = UserSession.new
    end
  end
end
