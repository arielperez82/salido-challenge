class Brand < ApplicationRecord
  has_many :locations
  has_many :menu_items
  has_many :price_levels
  has_many :order_types
end
