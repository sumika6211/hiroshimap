FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 5) }
    email { "example@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end