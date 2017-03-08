class CreateLocationMenuItems < ActiveRecord::Migration[5.0]
  def change
    create_table :location_menu_items do |t|
      t.references :location, foreign_key: true
      t.references :menu_item, foreign_key: true

      t.datetime :created_at, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :updated_at, default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
