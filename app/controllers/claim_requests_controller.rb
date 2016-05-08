class ClaimRequestsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]  #should happen first

  # remove :edit from before_action find_organization
  # before_action(:find_organization, {only: [:show, :update, :destroy]})

  before_action :find_organization, only: [:edit, :update, :destroy, :show]
  before_action :authorize_organization, only: [:edit, :update, :destroy]
  skip_before_action :authorize_organization

  def create
    @claim = ClaimRequest.new
    @claim.user = current_user
    @claim.organization = @organization
    redirect_to root_path, notice: "Claim Request Submitted!"
  end

  def update_status

  end

  private

  def find_organization
    @organization = Organization.find params[:id]
  end

  def organization_params
    params.require(:organization).permit([:name, :address, :overview, :employee_count, :tech_team_size, :website, :twitter, :published, :user_id, {technology_ids: []}])
  end

  def authorize_organization
    redirect_to root_path unless can? :cru, @organization
  end

end
