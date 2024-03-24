class ApplicationController < ActionController::Base
  unless :admin_controller?
    if controller_name != "homes" || controller_name != "homes"
      before_action :authenticate_user!, except: [:top, :spot, :area, :genre, :index]
    end
  end

  if controller_name == "homes"
    before_action :ensure_guest_user, only: [:edit]
  end
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_up_path_for(resource)
    flash[:notice] = "Welcome! You have signed up successfully."
    user_path(current_user)
  end

  def after_sign_in_path_for(resource)
    flash[:notice] = "Signed in successfully."
    user_path(current_user)
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = "Signed out successfully."
    root_path
  end

  private

  def admin_controller?
    self.class.module_parent_name == 'Admin'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
end
