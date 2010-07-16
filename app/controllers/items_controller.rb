class ItemsController < ApplicationController
  before_filter :require_user
#  before_filter :make_cents, :only=>[:create, :update]
  before_filter :filter_units, :only=>[:create, :update]
  
  def create
    if share=current_user.shares.find(params[:share_id])
      @item=Item.new(params[:item])
      if @item.save
        share.contributions.create :user=>current_user, :item=>@item
      else
        flash[:notice]='could not save'
      end
    else
      flash[:notice]='could not find required share'
    end
    
    redirect_back_or_default root_url
  end
  
  def destroy
    if item = current_user.items.find(params[:id])
      item.destroy
      redirect_back_or_default root_url
    end
  end
  
  def edit
    @item = current_user.items.find(params[:id])
  end
  
  def update
    if @item=current_user.items.find(params[:id])
      if @item.update_attributes(params[:item])
        redirect_back_or_default root_url
      else
        render :action => :edit
      end
    else
      redirect_back_or_default root_url
    end
  end
  
  private
  
  def make_cents
#    params[:item][:value] = params[:item][:value].to_f*100
  end
end
