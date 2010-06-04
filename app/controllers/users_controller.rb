class UsersController < ApplicationController
  before_filter :require_user, :only => [:show, :edit, :update]
  before_filter :require_no_user, :only => [:new]
  
  def new
    @invitation_token=params[:invitation_token]
    @invite=Invite.find_by_token(params[:invitation_token]) if params[:invitation_token]
    
    if !@invite
      @user = User.new
      @form_url = new_user_url
      return
    end
    
    if !@user=User.find_by_email(@invite.recipient_email)
      @user = User.new(:email=>@invite.recipient_email)
      @form_url = create_from_signup_url(params[:invitation_token])
      return
    end
    
# save invites path and redirect to login with message: please login to view this invitation
    flash[:notice] = "Please login to view your invites!"
    redirect_to login_url
  end
  
  def create
    @user = User.new(params[:user])
    logger.debug{'#### passed new user'}
    if @user.save
      flash[:notice] = "Account created!"
      
      if params[:invitation_token]
        if invite=Invite.find_by_token(params[:invitation_token])
          share=Share.find(invite.share_id)
          if @user.participations.create :user=>@user, :share=>share
            invite.destroy
          end
        end
      end
      redirect_to root_url
    else
      if params[:invitation_token]
        @form_url = create_from_signup_url(params[:invitation_token])
        render :action => :new
      else
        @form_url = new_user_url
        render :action => :new
      end
    end
  end
  
  def show
    @user = @current_user
  end
 
  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to user_url
    else
      render :action => :edit
    end
  end
end
