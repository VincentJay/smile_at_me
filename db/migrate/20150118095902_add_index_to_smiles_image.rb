class AddIndexToSmilesImage < ActiveRecord::Migration
  def change
  	add_index :smiles, :image, unique: true
  end
end
