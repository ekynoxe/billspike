class CreateInvites < ActiveRecord::Migration
  def self.up
    create_table :invites do |t|
      t.integer     :sender_id
      t.string      :recipient_email
      t.string      :token

      t.references  :share
      
      t.datetime    :sent_at
    end
  end

  def self.down
    drop_table :invites
  end
end
