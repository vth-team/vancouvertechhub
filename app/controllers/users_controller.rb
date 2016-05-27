class UsersController < ApplicationController
  def new
   @user = User.new
  end

  def edit
   @user = User.find_by_id params[:id]
   render "edit"
  end

  def create
    service = Users::SignUp.new(params: user_params)
    if service.call
      session[:user_id] = service.user.id
      render "users/account_verifications/create"
    else
      render :new
    end
  end


  def update
   @user = User.find_by_id params[:id]

   if @user.update user_params
     redirect_to root_path, notice: "Account Updated"
   else
     render :edit
   end
  end

  def destroy
   user = User.find_by_id params[:id]
   session[:user_id] = nil
   user.destroy
   redirect_to root_path, notice: "User deleted!"
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
