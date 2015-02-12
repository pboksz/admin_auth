class Admin::AdminsController < ::ApplicationController
  before_action :authenticate_admin!

  def index
    render :index, locals: { admins: admins_repository.all }
  end

  def new
    render :new, locals: { admin: admins_repository.new }
  end

  def create
    admin = admins_repository.create(create_params)

    if admin.persisted?
      redirect_to admin_admins_path(locale)
    else
      render :new, locals: { admin: admin }
    end
  end

  def edit
    render :edit, locals: { admin: admins_repository.find(params[:id]) }
  end

  def update
    admins_repository.update(params[:id], update_params)
    redirect_to admin_admins_path(locale)
  end

  def destroy
    admins_repository.destroy(params[:id])
    redirect_to admin_admins_path(locale)
  end

  private

  def create_params
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end

  def update_params
    params.require(:admin).permit(:password, :password_confirmation)
  end
end
