class AddSenderRecipientToRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :sender_id, :integer
    add_column :rooms, :recipient_id, :integer

    add_index :rooms, :sender_id
    add_index :rooms, :recipient_id
    add_index :rooms, [:sender_id, :recipient_id], unique: true
  end
end
