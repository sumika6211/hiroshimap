class Public::PostsController < ApplicationController
	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id
		if @post.save
			flash[:notice] = "You have created post successfully."
			redirect_to post_path(@post)
		else
			render :new
		end
	end

	def index
		@posts = Post.all.includes(:post_genres, :spot)
		@spots = Spot.all
		@genres = Genre.all
		@posts = @posts.where("spot.area_id": params[:area_id]) if params[:area_id].present?
		@posts = @posts.where(spot_id: params[:spot_id]) if params[:spot_id].present?
		@posts = @posts.where("post_genres.genre_id": params[:genre_id]) if params[:genre_id].present?
		@posts = @posts.where("name like ? or introduction like ?", "%#{params[:name]}%", "%#{params[:name]}%") if params[:name].present?
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
		if @post.update(post_params)
			flash[:notice] = "You have updated post successfully."
			redirect_to post_path(@post)
		else
			render :edit
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to posts_path
	end

	private

	def post_params
		params.require(:post).permit(:name, :introduction, :spot_id, :image, :address, :latitude, :longitude, genre_ids: [])
	end

	def post_to_hash(post)
    { id: post.id,
      name: post.name,
      lat: post.latitude,
      lng: post.longitude }
	end
end