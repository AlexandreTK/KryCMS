class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.integer :role_id, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
