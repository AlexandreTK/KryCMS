class CreateAllowedActions < ActiveRecord::Migration
  def change
    create_table :allowed_actions do |t|
      t.string :controller
      t.string :action

      t.timestamps null: false
    end
  end
end
