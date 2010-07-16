class Payment < ActiveRecord::Base
  has_one :transaction, :dependent => :destroy
  has_one :user, :through=>:transaction
  has_one :payee, :through=>:transaction, :class_name=>"User"
  has_one :share, :through=>:transaction
  
  validates_presence_of :value
  validates_numericality_of :value
  
  validates_presence_of :description
end