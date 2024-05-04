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
    visit new_post_path
  end

  context "フォーム確認" do
    it "nameフォーム" do
    end
    it "introductionフォーム" do
      expect(page).to have_field 'post[introduction]'
    end
    it "spotセレクトボックス" do
      expect(page).to have_field 'post[spot_id]'
    end
    it "imagesフォーム" do
      expect(page).to have_field 'post[images][]'
    end
    it "addressフォーム" do
      expect(page).to have_field 'post[address]'
    end
    it "latitudeフォーム" do
      expect(page).to have_field 'post[latitude]'
    end
    it "longitudeフォーム" do
      expect(page).to have_field 'post[longitude]'
    end
    it "latitudeフォームに値を設定する" do
      page.fill_in 'post[latitude]', with: 123
      expect(page.find('input[name="post[latitude]"]').value).to eq 123
    end
  end

  #context do
    #before do
      #fill_in 'post[name]', with: 'お好み焼き'
      #fill_in 'post[introduction]', with: '肉玉そば750円'
      #select '広島駅', from: 'post[spot_id]'
      #fill_in 'post[latitude]', with: 123
      #fill_in 'post[longitude]', with: 123
      #fill_in 'post[address]', with: Faker::Lorem.characters(number: 5)
      #attach_file 'post[images][]', "#{Rails.root}/spec/fixtures/files/image/no_image.jpg"
      #click_button '投稿する'
    #end
    #it do
      #expect(FactoryBot.build(:post)).to be_valid
      #expect(page).to have_content '投稿しました！'
    #end
  #end
end
