class Admin::BaseController < ApplicationController
  before_action :authenticate_admin!

  private

  def authenticate_admin!
    if !(user_signed_in? && user_is_admin?)
      redirect_to root_path, alert: "You are not allowed to access that page"
    end
  end

end
