class Public::FavoritesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    current_user.favorites.find_or_create_by(post_id: post.id)
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: post.id)
    favorite.destroy if favorite
    redirect_to post_path(post)
  end

end
