class CreateContributions < ActiveRecord::Migration
  def self.up
    create_table :contributions do |t|
      t.integer :item_id
      t.integer :user_id
      t.integer :share_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :contributions
  end
end
