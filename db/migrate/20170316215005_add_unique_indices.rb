class AddUniqueIndices < ActiveRecord::Migration[5.0]
  def change
    add_index :brands, :name, unique: true
    add_index :locations, [:brand_id, :name], unique: true
    add_index :order_types, [:brand_id, :name], unique: true
    add_index :menu_items, [:brand_id, :name], unique: true
    add_index :price_levels, [:brand_id, :name], unique: true
    add_index :day_parts, [:location_id, :name], unique: true
    add_index :location_menu_items, [:location_id, :menu_item_id], unique: true
    add_index :menu_item_prices, [:menu_item_id, :price_level_id], unique: true

    execute('CREATE UNIQUE INDEX lpl_4col_uq_idx ON location_price_levels (location_id, order_type_id, day_part_id, price_level_id) WHERE day_part_id IS NOT NULL;')

    execute('CREATE UNIQUE INDEX lpl_3col_uq_idx ON location_price_levels (location_id, order_type_id, price_level_id) WHERE day_part_id IS NULL;')
  end
end
