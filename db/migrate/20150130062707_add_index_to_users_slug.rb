class AddIndexToUsersSlug < ActiveRecord::Migration
  def change
  	add_index :users, :slug
  end
end
