class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.references  :user
      t.references  :currency
      t.string      :description
      t.float       :value
      
      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
