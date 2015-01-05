class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :favorer_id
      t.integer :favored_id

      t.timestamps
    end
    add_index :relationships, :favorer_id
    add_index :relationships, :favored_id
    add_index :relationships, [:favorer_id, :favored_id], unique: true
  end
end
