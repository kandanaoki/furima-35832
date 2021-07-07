FactoryBot.define do
  factory :tag do
    tag_name { Faker::Lorem.characters(number: 20) }
  end
end
