class Brand < ApplicationRecord
  has_many :locations, inverse_of: :brand, dependent: :destroy
  has_many :menu_items, inverse_of: :brand, dependent: :destroy
  has_many :price_levels, inverse_of: :brand, dependent: :destroy
  has_many :order_types, inverse_of: :brand, dependent: :destroy

  validates_presence_of :name

  accepts_nested_attributes_for :locations, allow_destroy: true
  accepts_nested_attributes_for :menu_items, allow_destroy: true
  accepts_nested_attributes_for :price_levels, allow_destroy: true
  accepts_nested_attributes_for :order_types, allow_destroy: true
end
