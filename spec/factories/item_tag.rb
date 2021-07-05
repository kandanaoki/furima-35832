FactoryBot.define do
  factory :item_tag do
    name               { Faker::Name.last_name }
    description        { Faker::Lorem.sentence }
    category_id        { Faker::Number.between(from: 2, to: 11) }
    status_id          { Faker::Number.between(from: 2, to: 7) }
    shipping_charge_id { Faker::Number.between(from: 2, to: 3) }
    prefecture_id      { Faker::Number.between(from: 2, to: 48) }
    days_to_ship_id    { Faker::Number.between(from: 2, to: 4) }
    price              { Faker::Number.between(from: 300, to: 9_999_999) }
    tag_name           { Faker::Lorem.characters(1..20) }
  end
end
