class HomesController < ApplicationController
  def top
  end

  def spot
    @spots = Spot.all
  end

  def new_guest
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
    end
    sign_in user
    redirect_to root_path, notice: "ゲストユーザーとしてログインしました"
  end

end