class Admin::PostCommentsController < ApplicationController
  layout "admin"
  before_action :authenticate_admin!

  def index
    @post_comments = PostComment.all.joins(:user)
    @post_comments = @post_comments.where("comment like ? or users.name like ?", "%#{params[:name]}%", "%#{params[:name]}%") if params[:name].present?
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to admin_post_comments_path
  end
end
