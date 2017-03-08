class DayPart < ApplicationRecord
  belongs_to :location
  has_many :location_price_levels, dependent: :destroy

  validates_presence_of :location
  validates_uniqueness_of :name, scope: :location
end
