class ItemsController < ApplicationController
  before_filter :require_user
  before_filter :make_cents, :only=>[:create, :update]
  
  def create

#    COULD THIS BE DONE WITH A collection.build like: 
#    item=Item.create(params[:item])
#    share=current_user.shares.find(params[:share_id])
#    current_user.contributions.create :share=>share, :item=>@item

    @item=current_user.items.build(params[:item])
    if share=current_user.shares.find(params[:share_id])
      share.contributions.create :user=>current_user, :item=>@item
    else
      flash[:notice]='there has been a problem finding the share to save the item on'
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
    params[:item][:value] = params[:item][:value].to_f*100
  end
end
