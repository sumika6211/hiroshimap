require 'rails_helper'

RSpec.describe "管理者機能", type: :system do
  let!(:admin) { create(:admin, email: 'admin@example.com', password: 'password') }

  before "管理者ログイン" do
    FactoryBot.create(:user)
    visit admin_session_path
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_on 'ログイン'
  end

  context "ログイン確認" do
    it "ログインに成功したか" do
      expect(page).to have_content 'ログインしました！'
      expect(current_path).to eq '/admin/users'
    end
  end
  context "navbarの確認" do
    it "ユーザー一覧へのリンク確認" do
      expect(page).to have_link, href: admin_users_path
    end
    it "コメント一覧へのリンク確認" do
      expect(page).to have_link, href: admin_post_comments_path
      visit admin_post_comments_path
      expect(current_path).to eq '/admin/post_comments'
    end
    it "スポット一覧へのリンク確認" do
      expect(page).to have_link, href: admin_spots_path
      visit admin_spots_path
      expect(current_path).to eq '/admin/spots'
    end
    it "エリア一覧へのリンク確認" do
      expect(page).to have_link, href: admin_areas_path
      visit admin_areas_path
      expect(current_path).to eq '/admin/areas'
    end
    it "ジャンル一覧へのリンク確認" do
      expect(page).to have_link, href: admin_genres_path
      visit admin_genres_path
      expect(current_path).to eq '/admin/genres'
    end
  end

  context "ユーザー管理" do
    before do
      visit admin_users_path
    end
    it "退会させるリンクが表示されるか" do
      expect(page).to have_content '退会させる'
    end
  end

end
