class Admin::SessionsController < Admin::BaseController
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

  def create_admin_session(admin)
    @current_admin = admin
    session[:admin_id] = admin.id.to_s
  end

  def destroy_admin_session
    @current_admin = nil
    session[:admin_id] = nil
  end

  def create_params
    params.require(:admin).permit(:email, :password)
  end
end
