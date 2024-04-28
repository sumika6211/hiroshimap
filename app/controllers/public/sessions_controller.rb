# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def after_sign_in_path_for(resource)
    flash[:notice] = "ログインしました！"
    user_path(current_user)
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = "ログアウトしました！"
    root_path
  end

end
