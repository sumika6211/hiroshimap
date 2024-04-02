class Public::HomesController < ApplicationController
  def top
    @posts = Post.all.includes(:favorites)
    @new_posts = @posts.limit(3).order(created_at: :desc)
    @popular_posts = @posts.favorited_order.limit(3)
  end

  def spot
    @spots = Spot.all
    @spots_json = @spots.map { |o| spot_to_hash(o) }.to_json
    @areas = Area.all
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