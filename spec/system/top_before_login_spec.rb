require 'rails_helper'

RSpec.describe "Tops", type: :system do
  before do
    visit root_path
  end

  context "navbarの確認" do
    it "トップページへのリンクがあるか" do
      expect(page).to have_link, href: root_path
    end
    it "スポット一覧へのリンクがあるか" do
      expect(page).to have_link, href: "/homes/spot"
    end
    it "新規登録画面へのリンクがあるか" do
      expect(page).to have_link, href: new_user_registration_path
    end
    it "ログイン画面へのリンクがあるか" do
      expect(page).to have_link, href: new_user_session_path
    end
  end
end
