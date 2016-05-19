class OrganizationsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :filter]

  before_action :find_organization, only: [:show, :edit, :update, :destroy]

  before_action :authorize_organization, only: [:edit, :update, :destroy]
  skip_before_action :authorize_organization

  def new
    @organization = Organization.new
  end

  def show

    @claimed = @organization.claim_requests.find_by_status(true)
    hosting_event
      respond_to do |format|
        format.html { render } # render organizations/show.html.erb
        format.json { render json: @organization.to_json }
        format.xml  { render xml: @organization.to_xml }
      end
  end

  def index
    # @organizations = Organization.all  # original
    # @organizations = Organization.paginate(:page => params[:page], :per_page => 3)
		# TODO: Strech: make unpublished organizations display greyed out
		if current_user && current_user.admin?
 			@organizations = Organization.page(params[:page]).per(18)
 		else
     	@organizations = Organization.published.page(params[:page]).per(18)
 		end
    # respond_to do |format|
      # format.html { render }
      # format.json { render json: @organizations }
    # end
  end

  def edit
    @organization = Organization.find params[:id]
  end

  def filter
    #puts ">>>>>>>>>>>>>>>>>>>>"
    #puts params[:data_value]
    organization_ids = params[:data_value]
    @organizations = Organization.where("id in (?)", organization_ids)
    #binding.pry
    respond_to do |format|
      format.js { render :filter_success }
    end
  end

  def update
    # @organization.slug = nil
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
    @organization       = Organization.new(organization_params)
    puts "#{@current_user}"
    puts "#{current_user}"
    @organization.user  = current_user
    if @organization.save
      flash[:notice] = "organization created!"

      redirect_to organization_path(@organization)
    else
      flash[:alert] = "organization didn't save!"

      render :new
    end
  end


private


  def find_organization
		if current_user && current_user.admin?
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
