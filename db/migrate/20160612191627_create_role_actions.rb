class CreateRoleActions < ActiveRecord::Migration
  def change
    create_table :role_actions do |t|

      t.references :role, index: true, foreign_key: true
      t.references :allowed_action, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
