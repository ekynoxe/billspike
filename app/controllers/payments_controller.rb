class PaymentsController < ApplicationController
  before_filter :require_user
  before_filter :filter_units, :only=>[:create, :update]
  
  def new
    @other_users = other_users(current_share)
    @payment = current_user.payments.new
  end
  
  def create
    if share=current_user.shares.find(params[:share_id])
      @payment=Payment.new(params[:payment])
      if @payment.save
        share.transactions.create :user=>current_user, :payment=>@payment, :payee_id=>params[:payee_id]
      else
        flash[:payment_notice]='could not save'
      end
    else
      flash[:payment_notice]='could not find required share'
    end
    
    redirect_back_or_default root_url
  end
  
  def edit
    @other_users = other_users(current_share)
    @payment = current_user.payments.find(params[:id])
  end
  
  def update
    if @payment=current_user.payments.find(params[:id])
      if @payment.update_attributes(params[:payment])
        redirect_back_or_default root_url
      else
        render :action => :edit
      end
    else
      redirect_back_or_default root_url
    end
  end
  
  def destroy
    if payment = current_user.payments.find(params[:id])
      payment.destroy
      redirect_back_or_default root_url
    end
  end
  
  def other_users(share)
    return share.users.find_all{|u| u!=current_user}
  end
end
