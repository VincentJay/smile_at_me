class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.string :content
      t.boolean :read_state

      t.timestamps
    end
  end
end
