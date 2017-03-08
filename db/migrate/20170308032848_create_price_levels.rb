class CreatePriceLevels < ActiveRecord::Migration[5.0]
  def change
    create_table :price_levels do |t|
      t.references :brand, null: false, foreign_key: true
      t.string :name, null: false

      t.datetime :created_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :updated_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
