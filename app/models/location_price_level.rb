class LocationPriceLevel < ApplicationRecord
  belongs_to :location, inverse_of: :price_levels
  belongs_to :order_type, inverse_of: :location_price_levels
  belongs_to :day_part, inverse_of: :location_price_levels, optional: true
  belongs_to :price_level, inverse_of: :location_price_levels

  validates_presence_of :location
  validates_presence_of :order_type
  validates_presence_of :price_level

  validates_uniqueness_of :price_level, scope: [:day_part, :order_type, :location]

  validate :must_match_brand, :must_match_location

  private

  def must_match_brand
    errors.add_to_base("This price level and location belong to different brands") unless location.brand.eql? price_level.brand
    errors.add_to_base("This order type and location belong to different brands") unless location.brand.eql? order_type.brand
  end

  def must_match_location
    if day_part.present?
      errors.add_to_base("This day part does not belong to this location") unless day_part.location.eql? location
    end
  end
end
