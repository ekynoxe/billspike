class User < ActiveRecord::Base

  acts_as_authentic do |c|
    c.login_field = 'email'
  end

  validates_presence_of   :username
  validates_uniqueness_of :username
  
  validates_presence_of   :email
  validates_uniqueness_of :email
  
  has_many :participations, :dependent => :destroy
  has_many :shares, :through => :participations

  has_many :contributions, :dependent => :destroy
  has_many :items, :through => :contributions
  
  has_many :transactions, :dependent => :destroy
  has_many :payments, :through => :transactions
  
  has_many :sent_invitations, :class_name => 'Invite', :foreign_key => 'sender_id'
  
  def grand_total
    return calculate(self.items)
  end
  
  def total_for_share(share_id)
    calculate(self.items.find(:all, :conditions=>["share_id=?", "#{share_id}"]))
  end
  
  def is_admin_for(share_id)
    shares = self.participations.all(:conditions=>{:share_id=>share_id,:admin=>true})
    !shares.empty?
  end
  
  private
  
  def calculate(items)
    items.inject(0) {|sum,n| sum + n.value }
  end
end