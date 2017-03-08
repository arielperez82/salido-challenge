class CreateLocationMenuItems < ActiveRecord::Migration[5.0]
  def change
    create_table :location_menu_items do |t|
      t.references :location, foreign_key: true, null: false
      t.references :menu_item, foreign_key: true, null: false

      t.datetime :created_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :updated_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
