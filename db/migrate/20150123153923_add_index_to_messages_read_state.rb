class AddIndexToMessagesReadState < ActiveRecord::Migration
  def change
  	add_index :messages, :read_state
  end
end
