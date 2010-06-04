class RemoveReferencesFromItem < ActiveRecord::Migration
  def self.up
    remove_column :items, :user_id
    remove_column :items, :share_id
  end

  def self.down
    add_column :items, :user_id, :integer
    add_column :items, :share_id, :integer
  end
end
