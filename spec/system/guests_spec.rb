require 'rails_helper'

RSpec.describe "ゲスト機能確認", type: :system do
  before do
    visit new_user_session_path
  end

  context "リンク表示の確認" do
    it do
      expect(page).to have_link 'ゲストとしてログインする', href: guest_sign_in_path
    end
  end

  context "ゲストユーザー情報確認" do
    it do
      click_on 'ゲストとしてログインする'
      expect(page).to have_content 'ゲストユーザーとしてログインしました'
    end
  end

  context "退会画面へのアクセス確認" do
    before do
      click_on 'ゲストとしてログインする'
    end
    it "退会画面アクセス" do
      visit withdrawal_confirm_path
      expect(current_path).to eq '/'
    end
  end
end
