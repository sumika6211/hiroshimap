class Admin::UsersController < ApplicationController
  layout "admin"
  before_action :authenticate_admin!

  def index
    @users = User.all
    @users = @users.where("name like ?", "%#{params[:name]}%") if params[:name].present?
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザーを削除しました。"
  end
end
