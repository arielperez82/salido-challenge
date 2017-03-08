class CreateMenuItemPrices < ActiveRecord::Migration[5.0]
  def change
    create_table :menu_item_prices do |t|
      t.references :menu_item, foreign_key: true, null: false
      t.references :price_level, foreign_key: true, null: false
      t.decimal :price, precision: 10, scale: 2, null: false

      t.datetime :created_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :updated_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
