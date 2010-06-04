class ChangePricesTypeToInt < ActiveRecord::Migration
  def self.up
    Item.reset_column_information
    say_with_time "Updating items" do
      items = Item.all
      items.each do |i|
        i.update_attribute(:value, i.value*100)
        i.save!
      end
    end
    
    Payment.reset_column_information
    say_with_time "Updating payments" do
      payments = Payment.all
      payments.each do |p|
        p.update_attribute(:value, p.value*100)
        p.save!
      end
    end

    change_column :items, :value, :int, :limit=>8
    change_column :payments, :value, :int, :limit=>8
  end

  def self.down
    change_column :items, :value, :float
    change_column :payments, :value, :float
    
    Item.reset_column_information
    say_with_time "Updating items" do
      items = Item.find_all
      items.each do |i|
        i.update_attribute(:value, i.value/100)
        i.save!
      end
    end
    
    Payment.reset_column_information
    say_with_time "Updating payments" do
      payments = Payment.find_all
      payments.each do |p|
        p.update_attribute(:value, p.value/100)
        p.save!
      end
    end

  end
end
