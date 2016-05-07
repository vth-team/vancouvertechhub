class OrganizationsController < ApplicationController

  before_action :find_organization, only: [:show, :edit, :update, :destroy]

  def new
    @organization = Organization.new
  end

  def edit
  end

  def show
  end

  def create

  end

private

  def find_organization
    @organization = Organization.find params[:id]
  end

  def organization_params
    params.require(:organization).permit(:name, :address, :overview, :employee_count, :tech_team_size, :website, :twitter, :published)
  end

end
