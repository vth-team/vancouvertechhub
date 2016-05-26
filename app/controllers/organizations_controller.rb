class OrganizationsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :filter]
  before_action :find_organization, only: [:show, :edit, :update, :destroy]

  ORGANIZATIONS_PER_PAGE = 18

  def new
    if current_user.organization.present?
      redirect_to organization_path(current_user.organization_id), alert: "You can only have one organization."
    end
    @organization = Organization.new
  end

  def show
    @claimed = @organization.claim_requests.find_by_status(true)
    @related_news_article_ids = OrganizationNews.where(organization_id: @organization.id)
    @news_articles = []
    @related_news_article_ids.each do |hi|
      @news_articles.push(NewsArticle.find(hi.news_article_id))
    end
    hosting_event

    respond_to do |format|
      format.html { render }
      format.json { render json: @organization.to_json }
    end
  end

  def index
    @technologies = Technology.all
    if current_user && user_is_admin?
      @organizations = Organization.page(params[:page]).per(ORGANIZATIONS_PER_PAGE)
    else
      @organizations = Organization.published.page(params[:page]).per(ORGANIZATIONS_PER_PAGE)
    end
  end

  def edit
    @organization = Organization.find params[:id]
    if current_user.organization != @organization
      redirect_to organization_path(current_user.organization_id), alert: "You cannot edit other people's organizations."
    end
  end

  def filter
    organization_ids = params[:data_value]
    @organizations = Organization.where("id in (?)", organization_ids)
    respond_to do |format|
      format.js { render :filter_success }
    end
  end

  def update
    if @organization.update organization_params
      redirect_to organization_path(@organization), notice: "Organization Updated!"
    else
      render :edit
    end
  end

  def destroy
    @organization.destroy
    redirect_to organizations_path, notice: "organization: #{@organization.name} deleted!"
  end

  def create
    @organization      = Organization.new(organization_params)
    @organization.user = current_user

    if @organization.save
      FetchOrganizationNewsJob.perform_now(@organization.name, @organization.id)
      if current_user.organization_id.present?
        redirect_to organization_path(current_user.organization_id), alert: "You can only have one organization."
      else
        redirect_to organization_path(@organization), notice: "Organization Created!"
      end
    else
      flash[:alert] = "organization didn't save!"
      render :new
    end
  end

  private

  def find_organization
    if current_user && user_is_admin?
      @organization = Organization.find params[:id]
    else
      @organization = Organization.published.find params[:id]
    end
  end

  def organization_params
    params.require(:organization).permit([:name, :address, :overview, :employee_count, :tech_team_size, :website, :twitter, :logo, :published, :image, :image2, :image3, :image4, :user_id, {technology_ids: []} ])
  end

  def authorize_organization
    redirect_to root_path unless can? :cru, @organization
  end

  def hosting_event
    events = Event.all
    org_add = @organization.address.split(",")[0]
    @find = events.where("location ILIKE ?", "%#{org_add}%")
  end
end
