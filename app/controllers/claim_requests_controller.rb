class ClaimRequestsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_organization, only: [:new, :create, :edit, :update, :show]

  def new
    @claims = ClaimRequest.all
    @user = current_user
    if @organization.user.present? || @user.organization.present?
      redirect_to organization_path(@organization), alert: "You either: (a) already have a company or (b) are trying to claim an already claimed company"
    end
  end

  def create
    if @organization.user.present? || @user.organization.present?
      redirect_to organization_path(@organization), alert: "You either: (a) already have a company or (b) are trying to claim an already claimed company"
    end
    @claim = ClaimRequest.new
    @claim.user = current_user
    @claim.organization = @organization
    if @claim.save
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
      redirect_to admin_users_path
    else
      flash[:notice] = "No"
      render admin_users_path
    end
  end

  def update_status
  end

  private

  def find_organization
    @organization = Organization.find params[:organization_id]
  end
  def find_user
    @user = User.find params[:user_id]
  end

  def find_claim
    @claim = ClaimRequest.find params[:claim_request_id]
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
