class LocationMenuItem < ApplicationRecord
  belongs_to :location
  belongs_to :menu_item

  validates_presence_of :location
  validates_presence_of :menu_item
  validates_uniqueness_of :menu_item, scope: :location
  validate :must_match_brand

  private

  def must_match_brand
    errors.add_to_base("This menu item does not exist for this location's brand") unless location.brand.eql? menu_item.brand
  end
end
