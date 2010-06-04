class Transaction < ActiveRecord::Base
  belongs_to  :payment
  belongs_to  :share
  belongs_to  :user
  belongs_to  :payee, :class_name=>"User"
end
