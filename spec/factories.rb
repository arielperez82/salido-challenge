FactoryGirl.define do
  factory :brand do
    name  { Faker::Company.name }

    factory :full_brand do
      after(:create) do |brand, evaluator|
        create_list(:full_location, 1, brand: brand)
        create_list(:menu_item, 1, brand: brand)
        create_list(:price_level, 1, brand: brand)
        create_list(:order_type, 1, brand: brand)
      end
    end
  end

  factory :location do
    name  { Faker::Address.street_name }

    factory :full_location do
      after(:create) do |location, evaluator|
        create_list(:day_part, 1, location: location)
      end
    end
  end

  factory :price_level do
    name  { Faker::Lorem.word }
  end

  factory :order_type do
    name  { Faker::Lorem.word }
  end

  factory :day_part do
    name  { Faker::Lorem.word }
  end

  factory :menu_item do
    name { Faker::Food.ingredient }
  end
end