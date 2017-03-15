class OrderType < ApplicationRecord
  belongs_to :brand, inverse_of: :order_types
  has_many :location_price_levels, inverse_of: :order_type, dependent: :destroy

  validates_presence_of :brand
  validates_presence_of :name
  validates_uniqueness_of :name, scope: :brand
end
