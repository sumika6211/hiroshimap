class Public::FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    current_user.favorites.find_or_create_by(post_id: @post.id)
    render 'public/favorites/button_toggle'
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy if favorite
    render 'public/favorites/button_toggle'
  end
end
