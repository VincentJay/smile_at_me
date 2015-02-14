class AddIndexToMessagesMessagesReceiverId < ActiveRecord::Migration
  def change
  	add_index :messages, :sender_id
  	add_index :messages, :receiver_id
  	add_index :messages, [:sender_id, :receiver_id], unique: true
  end
end
