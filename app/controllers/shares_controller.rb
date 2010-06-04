class SharesController < ApplicationController
  before_filter :require_user, :store_location
  before_filter :require_share, :except => [:index, :new, :create]
  before_filter :mailer_set_url_options, :only => [:request_payment]
  
  def index
    redirect_to root_url
  end
  
  def show
    @column_width=50
    @item = current_share.items.new
    @payment = current_share.payments.new
    
    @share_elements = current_share.get_all_elements
    @other_users = other_users(current_share)
  end
  
  def new
    @share=current_user.shares.new
  end
  
  def create
    @share=current_user.shares.build(params[:share])
    current_user.participations.create :user=>current_user, :share=>@share, :admin=>true
    
    if @share.save
      flash[:notice] = "Share created!"
      redirect_to share_url(@share.id)
    else
      render :action => :new
    end
  end
  
  def edit
    @share = current_user.shares.find(params[:id])
  end
  
  def update
    if @share = current_user.shares.find(params[:id])
      if @share.update_attributes(params[:share])
        flash[:notice] = "Share updated!"
        redirect_to share_url
      else
        render :action => :edit
      end
    end
  end
  
  def request_payment
    share = current_user.shares.find(params[:share_id])
    share.users.each do |u|
      UserMailer.deliver_payment_reminder(current_user,u,share)
    end
    flash[:notice] = "Reminders sent!"
    redirect_to share_path(share)
  end
  
  def other_users(share)
    return share.users.find_all{|u| u!=current_user}
  end
end