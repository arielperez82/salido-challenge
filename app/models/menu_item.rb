class MenuItem < ApplicationRecord
  belongs_to :brand

  has_many :menu_item_prices, dependent: :destroy
  has_many :location_menu_items, dependent: :destroy

  validates_presence_of :brand
  validates_presence_of :name
  validates_uniqueness_of :name, scope: :brand
end
