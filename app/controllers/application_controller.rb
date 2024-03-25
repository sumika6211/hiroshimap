class ApplicationController < ActionController::Base
  unless :admin_controller?
    if controller_name != "homes" || controller_name != "homes"
      before_action :authenticate_user!, except: [:top, :spot, :area, :genre, :index]
    end
  end

  if controller_name == "homes"
    before_action :ensure_guest_user, only: [:edit]
  end

  private

  def admin_controller?
    self.class.module_parent_name == "Admin"
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
end
