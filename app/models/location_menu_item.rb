class LocationMenuItem < ApplicationRecord
  belongs_to :location
  belongs_to :menu_item
end
