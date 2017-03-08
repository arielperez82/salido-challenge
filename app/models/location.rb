class Location < ApplicationRecord
  belongs_to :brand
  has_many :location_menu_items
end
