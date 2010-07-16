ActionController::Routing::Routes.draw do |map|
  
  map.login   'login',    :controller => 'user_sessions', :action => 'new',       :conditions => { :method => :get }
  map.connect 'login',    :controller => 'user_sessions', :action => 'create',    :conditions => { :method => :post }
  map.logout  'logout',  :controller => 'user_sessions', :action => 'destroy',   :conditions => { :method => :delete }
  
  map.signup    'signup/:invitation_token', :controller => 'users', :action => 'new', :invitation_token => nil,    :conditions => { :method => :get }
  map.create_from_signup 'signup/:invitation_token', :controller => 'users', :action => 'create', :invitation_token => nil,    :conditions => { :method => :post }
  map.connect   'signup', :controller => 'users', :action => 'create',    :conditions => { :method => :post }
  map.new_user  'signup', :controller => 'users', :action => 'new',    :conditions => { :method => :get }
  
  map.accept_invite  'shares/:share_id/invites/:invitation_token/accept', :controller => 'invites', :action => 'accept',     :conditions => { :method => :get }
  map.request_payment 'shares/:share_id/request_payment/',    :controller => 'shares', :action => 'request_payment'
  
  map.resources :users
  
  map.resources :shares do |shares|
    shares.resources :items, :payments, :invites
  end
  
  map.root :controller => "home"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
