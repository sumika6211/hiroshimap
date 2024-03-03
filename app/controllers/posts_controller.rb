class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "You have created post successfully."
      redirect_to post_path(@post.id)
    else
      render :new_post_path
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def index
  end

  def edit
  end

  private

  def post_params
    params.require(:post).permit(:name, :introduction, :image)
  end

end
