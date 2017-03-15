ActiveAdmin.register Location do
  belongs_to :brand

  permit_params :name,
                day_parts_attributes: [:id, :name, :_destroy],
                menu_items_attributes: [:id, :menu_item_id, :_destroy],
                price_levels_attributes: [:id, :order_type_id, :day_part_id, :price_level_id, :_destroy]

  filter :name

  index do
    column :name
    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs 'Basic Details' do
      f.input :name
    end

    tabs do
      tab 'Day Parts' do
        f.inputs 'Day Parts' do
          f.has_many :day_parts, heading: false, allow_destroy: true, new_record: 'Add Day Part' do |day_part|
            day_part.input :name
          end
        end
      end

      tab 'Menu Items' do
        f.inputs 'Menu Items' do
          f.has_many :menu_items, heading: false, allow_destroy: true, new_record: 'Add Menu Item' do |menu_item|
            menu_item.input :menu_item, as: :select, collection: f.object.brand.menu_items
          end
        end
      end

      tab 'Price Levels' do
        f.inputs 'Price Levels' do
          f.has_many :price_levels, heading: false, allow_destroy: true, new_record: 'Add Price Level' do |price_level|
            price_level.input :order_type, as: :select, collection: f.object.brand.order_types
            price_level.input :day_part, as: :select, collection: f.object.day_parts
            price_level.input :price_level, as: :select, collection: f.object.brand.price_levels
          end
        end
      end
    end
    f.actions
  end

  show do
    tabs do
      tab 'Menu Items' do
        table_for location.menu_items.sort_by { |a,b| a.menu_item.name  } do
          column (:name) { |m| m.menu_item.name }
        end
      end

      tab 'Day Parts' do
        table_for location.day_parts do
          column :name
        end
      end

      tab 'Price Levels' do
        table_for location.price_levels.sort_by { |a,b| a.order_type.name } do
          column(:order_type) { |p| p.order_type.name }
          column(:day_part) { |p| p.day_part ? p.day_part.name : 'Default' }
          column(:price_level) { |p| p.price_level.name }
        end
      end
    end
  end
end
