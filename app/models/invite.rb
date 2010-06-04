class Invite < ActiveRecord::Base
  validates_presence_of   :token
  validates_uniqueness_of :token
  validates_presence_of   :recipient_email
  
  belongs_to  :share
  belongs_to  :sender,    :class_name => 'User'

  before_create :generate_token
  
  protected
  def before_validation_on_create
    self.token = rand(36**8).to_s(36) if self.new_record? and self.token.nil?
  end

  private
  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
end
