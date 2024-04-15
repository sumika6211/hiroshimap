class Public::RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    current_user.followeds << @user
    redirect_to request.referer, notice: 'ユーザーをフォローしました'
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.followed_relationships.find_by(followed_id: user.id).destroy
    redirect_to  request.referer
  end

  def show
    @user = User.find(params[:user_id])
    @followeds = @user.followeds
    @folloewrs = @user.followers
  end

end
