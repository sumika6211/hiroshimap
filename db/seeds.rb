# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

genres = %w(
  ランチ
  ディナー
  カフェ
  居酒屋
  和食
  洋食
  各国料理
  お好み焼き
  汁なし担々麺
  牡蠣
  ～¥2,000
  ¥2,001～¥4,000
  ¥4,001～¥6,000
  ¥6,001～
)

areas = %w(
  広島市中心部
  広島市安佐南・北
  広島市佐伯区
  宮島周辺エリア
  しまなみ海道エリア
  安芸エリア
  備後エリア
  備北エリア
)

genres.each do |name|
  Genre.create!(name: name)
end

areas.each do |name|
  Area.create!(name: name)
end