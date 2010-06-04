class RemoveCurrency < ActiveRecord::Migration
  def self.up
    drop_table :currencies
    
    remove_column :items, :currency_id
    remove_column :payments, :currency_id
  end

  def self.down
    create_table :currencies do |t|
      t.string  :name
      t.string  :symbol
      t.string  :euro_value

      t.timestamps
    end
    
    add_column :items, :currency, :integer_id
    add_column :payments, :currency, :integer_id
  end
end
