FactoryBot.define do
  factory :post do
    name { "お好み焼き" }
    introduction { "肉玉そば750円" }
    spot_id { 1 }
    images { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/files/image/no_image.jpg')) }
    address { Faker::Lorem.characters(number: 5) }
    latitude { 123 }
    longitude { 123 }
    user
  end
end