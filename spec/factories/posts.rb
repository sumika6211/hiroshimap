FactoryBot.define do
  factory :post do
    name { "お好み焼き" }
    introduction { "肉玉そば750円" }
    spot_id { 1 }
    images { fixture_file_upload('/images/no_image.jpg') }
    address { Faker::Lorem.characters(number: 5) }
    latitude { Faker::Lorem.characters(number: 5).to_i }
    longitude { Faker::Lorem.characters(number: 5).to_i }
  end
end