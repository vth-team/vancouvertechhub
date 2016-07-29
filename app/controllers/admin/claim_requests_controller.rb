class Admin::ClaimRequestsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_organization, only: [:new, :create, :edit, :update, :show]
  before_action :authorize_claimability, only: [:new, :create]

  def new
    @claims = ClaimRequest.all
    @user = current_user
  end

  def create
    service = ClaimRequests::CreateClaim.new(user:         current_user,
                                             organization: @organization)
    if service.call
      redirect_to organization_path(@organization), notice: "Claim Request Submitted!"
    else
      redirect_to organization_path(@organization), alert: "Claim Request not saved!"
    end
  end

  def update
    claims_params = params.permit([:status])
    @claims = ClaimRequest.find params[:id]
    @claims.user.organization = @claims.organization
    @claims.organization.user = @claims.user
    if @claims.update claims_params
      @claims.user.save
      @claims.organization.save
      redirect_to admin_users_path, notice: "Claim Request updated."
    else
      redirect_to admin_users_path, alert: "Claim Request not updated."
    end
  end

  def destroy
    @claims = ClaimRequest.find params[:id]
    @claims.destroy
    redirect_to admin_users_path, notice: "Claim Request deleted."
  end

  def update_status
  end

  private

  def authorize_claimability
    if @organization.user.present? || current_user.organization.present?
      redirect_to organization_path(@organization), alert: "You either: (a) already have a company or (b) are trying to claim an already claimed company"
    end
  end

  def find_organization
    @organization = Organization.find params[:organization_id]
  end

  def organization_params
    params.require(:organization).permit([:id, :name, :address, :overview, :employee_count, :tech_team_size, :website, :twitter, :published, :user_id, {technology_ids: []}])
  end

  def claim_params
    params.require(:claim_request).permit([:id, :status, :organization_id, :user_id])
  end

  def organization_claimed?
    if ClaimRequest.find_by_id(@organization)
      true
    else
      false
    end
  end

  def authorize_organization
    redirect_to root_path unless can? :cru, @organization
  end

end
