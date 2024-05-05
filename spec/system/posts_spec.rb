require 'rails_helper'

RSpec.describe "投稿機能", type: :system do
  let!(:user) { create(:user, name: 'hoge', email: 'example@example', password: 'password') }
  let!(:area) { create(:area, name: '広島中心部') }
  let!(:spot) { create(:spot, name: '広島駅', area_id: area.id) }
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  scenario "投稿が成功するか" do
    expect {
      visit new_post_path
      fill_in "タイトル", with: 'お好み焼き'
      fill_in "紹介文", with: '肉玉そば750円'
      attach_file '画像', "#{Rails.root}/spec/fixtures/files/image/no_image.jpg"
      select '広島駅', from: 'post[spot_id]'
      fill_in "Address", with: Faker::Lorem.characters(number: 5)
      find("#post_latitude", visible: false).set('123')
      find("#post_longitude", visible: false).set('456')
      click_button "投稿する"
      expect(page).to have_content "投稿しました"
    }.to change(Post, :count).by(1)
  end

  scenario "Nameバリデーション" do
    expect {
      visit new_post_path
      fill_in "紹介文", with: '肉玉そば750円'
      attach_file '画像', "#{Rails.root}/spec/fixtures/files/image/no_image.jpg"
      select '広島駅', from: 'post[spot_id]'
      fill_in "Address", with: Faker::Lorem.characters(number: 5)
      find("#post_latitude", visible: false).set('123')
      find("#post_longitude", visible: false).set('456')
      click_button "投稿する"
      expect(page).to have_content "Name can't be blank"
    }.to change(Post, :count).by(0)
  end

  scenario "introductionバリデーション" do
    expect {
      visit new_post_path
      fill_in "タイトル", with: 'お好み焼き'
      attach_file '画像', "#{Rails.root}/spec/fixtures/files/image/no_image.jpg"
      select '広島駅', from: 'post[spot_id]'
      fill_in "Address", with: Faker::Lorem.characters(number: 5)
      find("#post_latitude", visible: false).set('123')
      find("#post_longitude", visible: false).set('456')
      click_button "投稿する"
      expect(page).to have_content "Introduction can't be blank"
    }.to change(Post, :count).by(0)
  end

  scenario "画像バリデーション" do
    expect {
      visit new_post_path
      fill_in "タイトル", with: 'お好み焼き'
      fill_in "紹介文", with: '肉玉そば750円'
      select '広島駅', from: 'post[spot_id]'
      fill_in "Address", with: Faker::Lorem.characters(number: 5)
      find("#post_latitude", visible: false).set('123')
      find("#post_longitude", visible: false).set('456')
      click_button "投稿する"
      expect(page).to have_content "Images can't be blank"
    }.to change(Post, :count).by(0)
  end

  scenario "spotバリデーション" do
    expect {
      visit new_post_path
      fill_in "タイトル", with: 'お好み焼き'
      fill_in "紹介文", with: '肉玉そば750円'
      attach_file '画像', "#{Rails.root}/spec/fixtures/files/image/no_image.jpg"
      fill_in "Address", with: Faker::Lorem.characters(number: 5)
      find("#post_latitude", visible: false).set('123')
      find("#post_longitude", visible: false).set('456')
      click_button "投稿する"
      expect(page).to have_content "Spot can't be blank"
    }.to change(Post, :count).by(0)
  end

  scenario "addressバリデーション" do
    expect {
      visit new_post_path
      fill_in "タイトル", with: 'お好み焼き'
      fill_in "紹介文", with: '肉玉そば750円'
      attach_file '画像', "#{Rails.root}/spec/fixtures/files/image/no_image.jpg"
      select '広島駅', from: 'post[spot_id]'
      find("#post_latitude", visible: false).set('123')
      find("#post_longitude", visible: false).set('456')
      click_button "投稿する"
      expect(page).to have_content "Address can't be blank"
    }.to change(Post, :count).by(0)
  end

  scenario "緯度経度バリデーション" do
    expect {
      visit new_post_path
      fill_in "タイトル", with: 'お好み焼き'
      fill_in "紹介文", with: '肉玉そば750円'
      attach_file '画像', "#{Rails.root}/spec/fixtures/files/image/no_image.jpg"
      select '広島駅', from: 'post[spot_id]'
      fill_in "Address", with: Faker::Lorem.characters(number: 5)
      click_button "投稿する"
      expect(page).to have_content "Latitude can't be blank"
      expect(page).to have_content "Longitude can't be blank"
    }.to change(Post, :count).by(0)
  end
end
