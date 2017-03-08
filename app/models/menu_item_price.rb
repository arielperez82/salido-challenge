class MenuItemPrice < ApplicationRecord
  belongs_to :menu_item
  belongs_to :price_level

  validates_presence_of :menu_item
  validates_presence_of :price_level
  validates_presence_of :price
  validates_uniqueness_of :price_level, scope: :menu_item
  validate :must_match_brand

  private

  def must_match_brand
    errors.add_to_base("This price level and menu item belong to different brands") unless menu_item.brand.eql? price_level.brand
  end
end
