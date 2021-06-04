FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end

    nickname              { Faker::Name.last_name }
    email                 { Faker::Internet.free_email }
    password              { Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3, min_numeric: 3) }
    password_confirmation { password }
    first_name            { person.first.kanji }
    last_name             { person.last.kanji }
    first_name_kana       { person.first.katakana }
    last_name_kana        { person.last.katakana }
    birth_date            { Faker::Date.between(from: '1930-01-01', to: '2016-12-31') }
  end
end
