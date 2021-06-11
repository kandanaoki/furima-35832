FactoryBot.define do
  factory :purchase_shipping_adress do
    address = Gimei.address
    address_number = Faker::Number.number(digits: 3).to_s.insert(1, "-").insert(3, "-")

    user_id       { Faker::Number.number}
    item_id       { Faker::Number.number}
    token         {"tok_abcdefghijk00000000000000000"}
    postal_code   { Faker::Number.number(digits: 7).to_s.insert(3, "-") }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city          { address.city.kanji  }
    address       { "#{address.town.kanji}#{address_number}" }
    building_name { Faker::Name.initials(number: 2) }
    phone_number  { Faker::Number.number(digits: 11) }

  end
end
