class CreateLocationMenuItemPrices < ActiveRecord::Migration[5.0]
  def change
    create_table :location_menu_item_prices do |t|
      t.references :location_menu_item, foreign_key: true
      t.references :order_type, foreign_key: true
      t.references :day_part, foreign_key: true
      t.decimal :price, precision: 10, scale: 2, null: false

      t.datetime :created_at, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :updated_at, default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
