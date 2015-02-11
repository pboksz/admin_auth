class Admin::SessionsController < Admin::BaseController
  skip_before_action :authenticate_admin!

  def new
    if current_admin
      redirect_to after_login_path(locale)
    else
      render :new, locals: { admin: admins_repository.new }
    end
  end

  def create
    admin = admins_repository.find(email: create_params[:email])

    if admin && admin.correct_password?(create_params[:password])
      create_admin_session(admin)
      redirect_to after_login_path(locale)
    else
      render :new, locals: { admin: admins_repository.new }
    end
  end

  def destroy
    destroy_admin_session
    redirect_to after_logout_path(locale)
  end

  private

  def create_params
    params.require(:admin).permit(:email, :password)
  end
end
