class PaymentsController < ApplicationController
  before_filter :require_user
  before_filter :make_cents, :only=>[:create, :update]
  
  def create
    @payment=current_user.payments.build(params[:payment])
    
    if(@payment && share=current_user.shares.find(params[:share_id]))
      share.transactions.create :user=>current_user, :payment=>@payment, :payee_id=>params[:payee_id]
    else
      flash[:notice]='there has been a problem finding the share to save the payment on'
    end
    
    redirect_back_or_default root_url
  end
  
  def edit
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
  
  private
  
  def make_cents
    params[:payment][:value] = params[:payment][:value].to_f*100
  end
end
