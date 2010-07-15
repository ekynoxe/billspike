class Share < ActiveRecord::Base
  has_many :participations, :dependent => :destroy
  has_many :users, :through => :participations
  
  has_many :contributions, :dependent => :destroy
  has_many :items, :through => :contributions
  
  has_many :transactions, :dependent => :destroy
  has_many :payments, :through => :transactions
  
  has_many :invites
  
  validates_presence_of :name
  
  def total
    self.items.inject(0) {|sum,n| sum + n.value }
  end
  
  def get_all_elements
    share_elements = Array.new
    share_elements << self.items << self.payments
    share_elements.flatten!.sort! { |a,b| a.created_at <=> b.created_at }
    
    share_elements
  end
  
  def amount_per_participant
    self.total / self.users.length unless self.users.empty?
  end
  
  def find_max_owed
    participant_amount = amount_per_participant
    max_owed=0
    self.users.each do |u|
      difference=participant_amount - u.total_for_share(self.id)
      max_owed = difference.abs unless difference.abs < max_owed
    end
    return max_owed
  end
  
  def calculate_total_for_user(user)
    user_payments_received  = self.user_payments_received_for_id(user.id).inject(0){|sum,payment| sum + payment.value}
    user_payments_sent      = self.user_payments_sent_for_id(user.id).inject(0){|sum,payment| sum + payment.value}
    
    return amount_per_participant - user.total_for_share(self.id) + user_payments_received - user_payments_sent
  end
  
  def user_payments_received_for_id(user_id)
    return self.payments.find(:all,:conditions=>["payee_id=?", user_id])
  end
  
  def user_payments_sent_for_id(user_id)
    return self.payments.find(:all,:conditions=>["user_id=?", user_id])
  end
end
