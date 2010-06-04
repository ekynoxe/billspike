class AddUserRefToShare < ActiveRecord::Migration
  def self.up
    add_column :shares, :user_id, :integer
  end

  def self.down
    remove_column :shares, :user_id
  end
end
