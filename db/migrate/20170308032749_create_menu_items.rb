class CreateMenuItems < ActiveRecord::Migration[5.0]
  def change
    create_table :menu_items do |t|
      t.references :brand, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
