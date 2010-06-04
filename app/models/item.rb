class Item < ActiveRecord::Base
  has_one :contribution, :dependent => :destroy
  has_one :user, :through=>:contribution
  has_one :share, :through=>:contribution
  
  validates_presence_of :value
  validates_numericality_of :value
  validates_presence_of :description
end