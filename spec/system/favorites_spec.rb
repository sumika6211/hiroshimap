require 'rails_helper'

RSpec.describe "Favorites", type: :system do
  let!(:user) { create(:user, name: 'hoge',email: 'example@example',password: 'password') }
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
    visit post_path
  end
end
