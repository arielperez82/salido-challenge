require 'rails_helper'

RSpec.describe Location, type: :model do
  let(:brand) { FactoryGirl.create(:full_brand) }
  let(:menu_item) { brand.menu_items.first }
  let(:location) { brand.locations.first }
  let(:order_type_price_level) { brand.price_levels.first }
  let(:order_type) { brand.order_types.first }
  let(:day_part) { location.day_parts.first }
  let(:order_type_price) { 50 }
  let(:day_part_price) { 75 }

  describe "#get_menu_item_price_and_level" do
    context "when menu item is configured for location" do
      before(:each) do
        location.menu_items.create(menu_item: menu_item)
      end

      it "returns nil when no price levels are configured for this menu item" do
        expect(location.get_menu_item_price_and_level(menu_item, order_type)).to be_nil
        expect(location.get_menu_item_price_and_level(menu_item, order_type, day_part)).to be_nil
      end

      context "when menu item is configured for price level" do
        before(:each) do
          menu_item.prices.create(price_level: order_type_price_level, price: order_type_price)
        end

        it "returns nil when no price levels are configured for this order type" do
          expect(location.get_menu_item_price_and_level(menu_item, order_type)).to be_nil
        end

        context "when price level is configured for order type" do
          before(:each) do
            location.price_levels.create(price_level: order_type_price_level, order_type: order_type)
          end

          it "returns the configured price level for this menu item, order type" do
            menu_item_price = location.get_menu_item_price_and_level(menu_item, order_type)
            expect(menu_item_price[:price_level]).to eq(order_type_price_level)
            expect(menu_item_price[:price]).to eq(order_type_price)
          end

          it "returns the configured price for this menu item, order type, and any day part" do
            random_day_part = FactoryGirl.create(:day_part, location: location)

            menu_item_price = location.get_menu_item_price_and_level(menu_item, order_type, random_day_part)
            expect(menu_item_price[:price_level]).to eq(order_type_price_level)
            expect(menu_item_price[:price]).to eq(order_type_price)
          end

          context "when price level is configured for day part" do
            let(:day_part_price_level) { FactoryGirl.create(:price_level, brand: brand) }
            before(:each) do
              location.price_levels.create(price_level: day_part_price_level, order_type: order_type, day_part: day_part)
              menu_item.prices.create(price_level: day_part_price_level, price: day_part_price)
            end

            context "when day part is the configured day part" do
              it "returns the configured price for this menu item, order type, day part" do
                menu_item_price = location.get_menu_item_price_and_level(menu_item, order_type, day_part)
                expect(menu_item_price[:price_level]).to eq(day_part_price_level)
                expect(menu_item_price[:price]).to eq(day_part_price)
              end
            end

            context "when day part is not the configured day part" do
              let(:non_configured_day_part) { FactoryGirl.create(:day_part, location: location) }

              it "returns the configured price for this menu item, order type" do
                menu_item_price = location.get_menu_item_price_and_level(menu_item, order_type, non_configured_day_part)
                expect(menu_item_price[:price_level]).to eq(order_type_price_level)
                expect(menu_item_price[:price]).to eq(order_type_price)
              end
            end
          end
        end
      end
    end
  end
end
