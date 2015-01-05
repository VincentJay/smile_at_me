class CreateSmiles < ActiveRecord::Migration
  def change
    create_table :smiles do |t|
      t.string :image
      t.integer :user_id

      t.timestamps
    end
    add_index :smiles, [:user_id, :created_at]
  end
end
