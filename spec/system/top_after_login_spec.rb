require 'rails_helper'

RSpec.describe "Tops", type: :system do
  let!(:user) { create(:user, name: 'hoge',email: 'example@example',password: 'password') }
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
    visit root_path
  end

  context "navbarの確認" do
    it "トップページへのリンクがあるか" do
      expect(page).to have_link, href: root_path
    end
    it "スポット一覧へのリンクがあるか" do
      expect(page).to have_link, href: "/homes/spot"
    end
    it "マイページへのリンクがあるか" do
      expect(page).to have_link, href: user_path(:user)
    end
    it "ログアウトへのリンクがあるか" do
      expect(page).to have_link, href: destroy_user_session_path
    end
  end

  context "トップページの確認" do

  end

end
