class AddShareRefToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :share_id, :integer
  end

  def self.down
    remove_column :items, :share_id
  end
end
