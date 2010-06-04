class Contribution < ActiveRecord::Base
  belongs_to  :item
  belongs_to  :share
  belongs_to  :user
end
