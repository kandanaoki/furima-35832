FactoryBot.define do
  factory :shipping_address do
    address = Gimei.address
    address_number = Faker::Number.number(digits: 3).to_s.insert(1, '-').insert(3, '-')

    postal_code   { Faker::Number.number(digits: 7).to_s.insert(3, '-') }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city          { address.city.kanji }
    address       { "#{address.town.kanji}#{address_number}" }
    building_name { Faker::Name.initials(number: 2) }
    phone_number  { Faker::Number.number(digits: 11) }
  end
end
