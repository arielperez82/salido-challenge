class LocationPriceLevel < ApplicationRecord
  belongs_to :location
  belongs_to :order_type
  belongs_to :day_part, optional: true
  belongs_to :price_level

  validates_presence_of :location
  validates_presence_of :order_type
  validates_presence_of :price_level

  validates_uniqueness_of :price_level, scope: [:order_type, :day_part]

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
