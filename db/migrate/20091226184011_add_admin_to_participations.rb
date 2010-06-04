class AddAdminToParticipations < ActiveRecord::Migration
  def self.up
    add_column :participations, :admin, :boolean, :default=>false
  end

  def self.down
    remove_column :participations, :admin
  end
end
