class AddAreaIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :area_id, :integer
  end
end
