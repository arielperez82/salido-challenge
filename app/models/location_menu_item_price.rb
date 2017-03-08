class LocationMenuItemPrice < ApplicationRecord
  belongs_to :location_menu_item
  belongs_to :order_type
  belongs_to :day_part
end
