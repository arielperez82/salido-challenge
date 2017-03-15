class LocationMenuItem < ApplicationRecord
  belongs_to :location, inverse_of: :menu_items
  belongs_to :menu_item, inverse_of: :location_menu_items

  validates_presence_of :location
  validates_presence_of :menu_item
  validates_uniqueness_of :menu_item, scope: :location
  validate :must_match_brand

  delegate :prices, to: :menu_item

  private

  def must_match_brand
    Rails.logger.info location.inspect
    Rails.logger.info menu_item.inspect
    errors.add_to_base("This menu item does not exist for this location's brand") unless location.brand.eql? menu_item.brand
  end
end
