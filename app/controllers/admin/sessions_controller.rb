class Admin::SessionsController < Admin::BaseController
  skip_before_action :authenticate_admin!

  def new
    if current_admin
      redirect_to after_login_path
    else
      render :new, locals: { admin: admins_repository.new }
    end
  end

  def create
    admin = admins_repository.find(email: create_params[:email])

    if admin && admin.correct_password?(admin.id, create_params[:password])
      admins_repository.update_login_information(admin.id)
      create_admin_session(admin)

      redirect_to after_login_path
    else
      render :new, locals: { admin: admins_repository.new }
    end
  end

  def destroy
    destroy_admin_session
    redirect_to after_logout_path
  end

  private

  def admins_repository
    @admins_repository ||= Repository.new
  end

  def create_params
    params.require(:admin).permit(:email, :password)
  end
end
