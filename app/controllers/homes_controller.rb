class HomesController < ApplicationController
  def top
  end

  def spot
    @spots = Spot.all
    @spots_json = @spots.map { |o| spot_to_hash(o) }.to_json
  end

  def area
    @areas = Area.all
  end

  def genre
    @genres = Genre.all
  end

  def new_guest
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
    end
    sign_in user
    redirect_to root_path, notice: "ゲストユーザーとしてログインしました"
  end

  private

  def spot_to_hash(spot)
    { id: spot.id,
      name: spot.name,
      lat: spot.latitude,
      lng: spot.longitude }
  end

end