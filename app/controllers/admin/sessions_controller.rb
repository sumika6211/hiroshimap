# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  layout "admin"

  protected

  def after_sign_in_path_for(resource)
    flash[:notice] = "ログインしました！"
    admin_users_path
  end

  def after_sign_out_path_for(resource_or_scope)
    flash[:notice] = "ログアウトしました！"
    new_admin_session_path
  end
end
