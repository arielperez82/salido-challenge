ActiveAdmin.register MenuItem do
  belongs_to :brand

  permit_params :name,
                prices_attributes: [:id, :price_level_id, :price, :_destroy]

  filter :name

  index do
    column :name
    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs 'Menu Item' do
      f.input :name
      f.inputs 'Prices' do
        f.has_many :prices, heading: false, allow_destroy: true, new_record: 'Add Price' do |price|
          price.input :price_level, as: :select, collection: f.object.brand.price_levels
          price.input :price
        end
      end
    end

    f.actions
  end

  show do
    panel "Prices" do
      table_for menu_item.prices do
        column (:price_level) { |p| p.price_level.name }
        column (:price) { |p| number_to_currency(p.price) }
      end
    end
  end
end
