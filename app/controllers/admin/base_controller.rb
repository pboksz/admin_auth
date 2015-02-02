class Admin::BaseController < ApplicationController
  before_action :authenticate_admin!
  def authenticate_admin!
    redirect_to admin_login_path(locale) unless current_admin
  end

  helper_method :locale
  def locale
    params[:locale]
  end

  helper_method :current_admin
  def current_admin
    @current_admin ||= admins_repository.find(id: session[:admin_id]) if session[:admin_id]
  end

  def create_admin_session(admin)
    @current_admin = admin
    session[:admin_id] = admin.id.to_s
  end

  def destroy_admin_session
    @current_admin = nil
    session[:admin_id] = nil
  end

  def after_login_path(new_locale = locale)
    defined?(super) ? super(new_locale) : root_path(new_locale)
  end

  def after_logout_path(new_locale = locale)
    defined?(super) ? super(new_locale) : root_path(new_locale)
  end

  private

  def admins_repository
    @admins_repository ||= AdminAuth::Repository.new
  end
end
