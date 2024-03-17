class PostsController < ApplicationController
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
		@posts = Post.all
		@spots = Spot.all
		@genres = Genre.all
		@posts = @posts.where(spot_id: params[:spot_id]) if params[:spot_id].present?
		if params[:area_id].present?
			@spots = @spots.where(area_id: params[:area_id])
			@posts = @posts.where(spot_id: @spots)
		end
		#@posts = @posts.where(genre_ids: params[:genre_id]) if params[:genre_id].present?
		@posts = @posts.where("name or introduction like ?", "%#{params[:name]}%") if params[:name].present?
		@posts = @posts.favorited_order if params[:favorites].present?
	end

	def show
		@post = Post.find(params[:id])
		@post_comment = PostComment.new
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
		params.require(:post).permit(:name, :introduction, :image, :spot_id, genre_ids: [])
	end
end