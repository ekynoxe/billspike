class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.references  :currency
      t.float       :value

      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end