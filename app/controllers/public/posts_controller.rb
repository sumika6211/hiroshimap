class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿しました!"
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def index
    @posts = Post.all.includes(:post_genres, :spot)
    @spots = Spot.all
    @genres = Genre.all
    @posts = @posts.where("spots.area_id": params[:area_id]) if params[:area_id].present?
    @posts = @posts.where(spot_id: params[:spot_id]) if params[:spot_id].present?
    @posts = @posts.where("post_genres.genre_id": params[:genre_id]) if params[:genre_id].present?
    @posts = @posts.where("posts.name like ? or introduction like ?", "%#{params[:name]}%", "%#{params[:name]}%") if params[:name].present?
    @posts = @posts.favorited_order if params[:favorites].present?
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_json = post_to_hash(@post).to_json
  end

  def edit
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to post_path(params[:id])
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.user == current_user
      if @post.update(post_params)
        flash[:notice] = "投稿編集完了!"
        redirect_to post_path(@post)
      else
        render :edit
      end
    else
      redirect_to post_path(@post)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user == current_user
      @post.destroy
      flash[:notice] = "投稿を削除しました"
      redirect_to posts_path
    else
      redirect_to post_path(@post)
    end
  end

  private

  def post_params
    params.require(:post).permit(:name, :introduction, :spot_id, :address, :latitude, :longitude, images: [], genre_ids: [])
  end

  def post_to_hash(post)
    { id: post.id,
      name: post.name,
      lat: post.latitude,
      lng: post.longitude }
  end
end