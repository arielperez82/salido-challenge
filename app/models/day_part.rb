class DayPart < ApplicationRecord
  belongs_to :location, inverse_of: :day_parts
  has_many :location_price_levels, inverse_of: :day_part, dependent: :destroy

  validates_presence_of :location
  validates_uniqueness_of :name, scope: :location
end
