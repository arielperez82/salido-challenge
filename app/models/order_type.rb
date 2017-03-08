class OrderType < ApplicationRecord
  belongs_to :brand
  has_many :location_price_levels, dependent: :destroy

  validates_presence_of :brand
  validates_presence_of :name
  validates_uniqueness_of :name, scope: :brand
end
