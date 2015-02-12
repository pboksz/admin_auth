module AdminAuth
  module Controller
    def self.included(controller)
      controller.helper_method :current_admin
      controller.helper_method :locale
    end

    def authenticate_admin!
      redirect_to admin_login_path(locale) unless current_admin
    end

    def current_admin
      @current_admin ||= admins_repository.find(id: session[:admin_id]) if session[:admin_id]
    end

    def locale
      params[:locale]
    end

    def after_login_path(new_locale = locale)
      admin_admins_path(new_locale)
    end

    def after_logout_path(new_locale = locale)
      admin_root_path(new_locale)
    end

    private

    def admins_repository
      @admins_repository ||= Repository.new
    end
  end
end
