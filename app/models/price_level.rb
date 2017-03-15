class PriceLevel < ApplicationRecord
  belongs_to :brand, inverse_of: :price_levels
  has_many :menu_item_prices, inverse_of: :price_level, dependent: :destroy
  has_many :location_price_levels, inverse_of: :price_level, dependent: :destroy

  validates_presence_of :brand
  validates_presence_of :name
  validates_uniqueness_of :name, scope: :brand
end
