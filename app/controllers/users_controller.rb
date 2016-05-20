class UsersController < ApplicationController
  def new
   @user = User.new
<<<<<<< 63c654688f33e86be28c5c5863cea7f747ecacf6
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
=======
 end

  def edit
    @organizations = Organization.where(user_id: nil)
    @user = User.find_by_id params[:id]
    # the page is passed in by application.html.erb
    # via <%= link_to "Edit Profile", edit_user_path(user_id: current_user.id, page: "password_reset") %>
    render "edit"
  end

 def create
   # we generate the password_digest automatically
   # has_secure_password make sure password == password_confirmation
   user_params = params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
   @user = User.new user_params

   if @user.save
     session[:user_id] = @user.id
     #redirect_to root_path, notice: "Account Created!"
     @user.generate_account_verification_data
     AccountVerificationsMailer.send_verification_instructions(@user).deliver_later
     render "users/account_verifications/create"

   else
     render :new
   end

 end

>>>>>>> wip, rebasing from parent branch

def update
  @user = User.find_by_id params[:id]
  if can? :manage, @user
    user_params = params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin, :organization_id)
  else
    user_params = params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  if @user.update user_params
    redirect_to root_path, notice: "Account Updated"
  else
    render :edit
  end
<<<<<<< 63c654688f33e86be28c5c5863cea7f747ecacf6

  def destroy
=======
end


 def destroy
>>>>>>> wip, rebasing from parent branch
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
