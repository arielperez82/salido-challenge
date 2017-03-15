class CreateLocationPriceLevels < ActiveRecord::Migration[5.0]
  def change
    create_table :location_price_levels do |t|
      t.references :location, foreign_key: true, null: false
      t.references :order_type, foreign_key: true, null: false
      t.references :day_part, foreign_key: true
      t.references :price_level, foreign_key: true

      t.datetime :created_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :updated_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
