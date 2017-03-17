ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: 'Test'

  content title: 'Brand and Location Configuration Testing' do
    panel 'Filters' do
      form_for '' do |f|
        span do
          f.label :brand_id
        end
        f.select :brand_id, Brand.all.map{|b| [b.name, b.id]}, { include_blank: true}, onchange: "reloadData('brands');"

        span do
          f.label :location_id
        end
        f.select :location_id, [], { include_blank: true }, onchange: "reloadData('locations');"

        span do
          f.label :menu_item_id
        end
        f.select :menu_item_id, [], { include_blank: true }, onchange: 'updateMenuItemPrice();'

        span do
          f.label :order_type_id
        end
        f.select :order_type_id, [], { include_blank: true }, onchange: 'updateMenuItemPrice();'

        span do
          f.label :day_part_id
        end
        f.select :day_part_id, [], { include_blank: true }, onchange: 'updateMenuItemPrice();'
      end
    end

    panel 'Configured Price' do
      h3 'Price Level:' do
        span 'Select Filter', id: 'price_level'
      end
      h3 'Price:' do
        span '-', id: 'price'
      end
    end
  end
end
