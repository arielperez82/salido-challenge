class Location < ApplicationRecord
  belongs_to :brand
  has_many :day_parts, dependent: :destroy
  has_many :location_price_levels, dependent: :destroy
  has_many :location_menu_items, dependent: :destroy

  validates_presence_of :brand
  validates_uniqueness_of :name, scope: :brand
end
