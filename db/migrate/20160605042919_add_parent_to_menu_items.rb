class AddParentToMenuItems < ActiveRecord::Migration
  def change
  	add_column :menu_items, :parent_id, :integer
  end
end
