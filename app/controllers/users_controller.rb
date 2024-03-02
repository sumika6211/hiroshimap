class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if @user.email == 'guest@example.com'
      redirect_to root_path
    end
  end

  def edit
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
    if current_user.email == 'guest@example.com'
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def withdrawal_confirm
    @user = User.find(current_user.id)
    if current_user.email == 'guest@example.com'
      redirect_to root_path
    end
  end

  def destroy
    user = User.find(current_user.id)
    user.destroy
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
