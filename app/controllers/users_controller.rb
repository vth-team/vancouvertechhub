class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def edit
    @organizations = Organization.unclaimed
    # The line below adds to the dropdown of organizations the users current organization.
    @organizations.push @user.organization if @user.organization.present?
  end

  def create
    service = Users::SignUp.new(params: user_params)
    if service.call
      session[:user_id] = service.user.id
      render "users/account_verifications/create"
    else
      @user = service.user
      render :new
    end
  end

  def update
    if @user.update update_user_params
      redirect_to admin_users_path, notice: "Account Updated"
    else
      render :edit
    end
  end

  def destroy
    if current_user == @user
      session[:user_id] = nil
      path = root_path
    else
      path = admin_users_path
    end
    @user.destroy
    redirect_to path, notice: "User deleted!"
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def find_user
    @user ||= User.find params[:id]
  end

  def update_user_params
    if can? :manage, @user
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin, :organization_id)
    else
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
  end

end
