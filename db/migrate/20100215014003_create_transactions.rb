class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.integer :payment_id
      t.integer :user_id
      t.integer :payee_id
      t.integer :share_id

      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
