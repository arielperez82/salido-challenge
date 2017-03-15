class MenuItem < ApplicationRecord
  belongs_to :brand, inverse_of: :menu_items

  has_many :prices, class_name: 'MenuItemPrice', inverse_of: :menu_item, dependent: :destroy
  has_many :location_menu_items, inverse_of: :menu_item, dependent: :destroy

  validates_presence_of :brand
  validates_presence_of :name
  validates_uniqueness_of :name, scope: :brand

  accepts_nested_attributes_for :prices, allow_destroy: :true
end
