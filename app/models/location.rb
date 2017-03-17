class Location < ApplicationRecord
  belongs_to :brand, inverse_of: :locations

  has_many :day_parts, inverse_of: :location, dependent: :destroy
  has_many :price_levels, inverse_of: :location, class_name: 'LocationPriceLevel', dependent: :destroy
  has_many :menu_items, inverse_of: :location, class_name: 'LocationMenuItem', dependent: :destroy

  accepts_nested_attributes_for :day_parts, allow_destroy: true
  accepts_nested_attributes_for :price_levels, allow_destroy: true
  accepts_nested_attributes_for :menu_items, allow_destroy: true

  validates_presence_of :brand
  validates_uniqueness_of :name, scope: :brand

  def get_menu_item_price_and_level(menu_item, order_type, day_part = nil)
    location_menu_item = menu_items.where(menu_item_id: menu_item).first

    if location_menu_item.present?
      menu_item_prices = location_menu_item.prices

      order_type_location_price_levels = price_levels.where(order_type_id: order_type).all
      if order_type_location_price_levels.present?
        day_part_location_price_levels = order_type_location_price_levels.select { |l| l.day_part.eql? day_part }
        if day_part.present?
          day_part_location_price_levels << order_type_location_price_levels.find { |l| l.day_part.nil? }
        end

        valid_price_levels = Set.new(day_part_location_price_levels.compact.map(&:price_level))
        valid_price_levels.each do |p|
          if menu_item_price = menu_item_prices.find { |m| m.price_level.eql? p }
            return { price_level: menu_item_price.price_level, price: menu_item_price.price }
          end
        end
      end
    end

    nil
  end
end
