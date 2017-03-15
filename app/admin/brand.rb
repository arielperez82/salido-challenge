ActiveAdmin.register Brand do
  permit_params :name,
                locations_attributes: [:id, :name, :_destroy],
                menu_items_attributes: [:id, :name, :_destroy],
                price_levels_attributes: [:id, :name, :_destroy],
                order_types_attributes: [:id, :name, :_destroy]

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
      tab 'Locations' do
        f.inputs 'Locations' do
          f.has_many :locations, heading: false, allow_destroy: true, new_record: 'Add Location' do |location|
            location.input :name
          end
        end
      end

      tab 'Menu Items' do
        f.inputs 'Menu Items' do
          f.has_many :menu_items, heading: false, allow_destroy: true, new_record: 'Add Menu Item' do |menu_item|
            menu_item.input :name
          end
        end
      end

      tab 'Price Levels' do
        f.inputs 'Price Levels' do
          f.has_many :price_levels, heading: false, allow_destroy: true, new_record: 'Add Price Level' do |price_level|
            price_level.input :name
          end
        end
      end

      tab 'Order Types' do
        f.inputs 'Order Types' do
          f.has_many :order_types, heading: false, allow_destroy: true, new_record: 'Add Order Type' do |order_type|
            order_type.input :name
          end
        end
      end
    end
    f.actions
  end

  show do
    tabs do
      tab 'Locations' do
        table_for brand.locations.sort_by { |a,b| a.name  } do
          column :name
          column (:actions) do |l|
            span link_to('View', admin_brand_location_path(brand, l))
            span link_to('Edit', edit_admin_brand_location_path(brand, l))
          end
        end
      end

      tab 'Menu Items' do
        table_for brand.menu_items.sort_by { |a,b| a.name  } do
          column :name
          column (:actions) do |m|
            span link_to('View', admin_brand_menu_item_path(brand, m))
            span link_to('Edit', edit_admin_brand_menu_item_path(brand, m))
          end
        end
      end

      tab 'Price Levels' do
        table_for brand.price_levels do
          column :name
        end
      end

      tab 'Order Types' do
        table_for brand.order_types do
          column :name
        end
      end
    end
  end
end
