class InvitesController < ApplicationController
  before_filter :require_user, :require_share
  before_filter :mailer_set_url_options
  
  def index
    @invites = current_share.invites.all
  end
  
  def show
    if !@invite = self.find_by_token(params[:token])
      redirect_to root_url
    end
  end
  
  def new
    @invite=current_share.invites.new
  end
  
  def create
    invite_params=params[:invite]
    invite_params[:sent_at]=Time.now
    invite_params[:sender_id]=current_user.id
    
    @invite=current_share.invites.build(invite_params)
    
    if @invite.save
      UserMailer.deliver_invitation(@invite,share)
      flash[:notice] = "Invite created!"
      redirect_to share_url(current_share)
    else
      render :action => :new
    end
  end
  
  def accept
    if invite = Invite.find_by_token(params[:invitation_token])
      share=Share.find(invite.share_id)
      if current_user.participations.create :user=>current_user, :share=>share
        invite.destroy
      end
    end
    
    redirect_back_or_default root_url
  end
  
  private
  
  def find_by_token(token)
    invite = Invite.find(:first, :conditions=>conditions = ["token=?", "#{params[:token]}"])
    invite
  end
end