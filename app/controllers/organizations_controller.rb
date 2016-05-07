class OrganizationsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  before_action :find_organization, only: [:show, :edit, :update, :destroy]
  before_action :authorize_organization, only: [:edit, :update, :destroy]
  skip_before_action :authorize_organization

  def new
    @organization = Organization.new
  end

  def show
      respond_to do |format|
        format.html { render } # render organizations/show.html.erb
        format.json { render json: @organization.to_json }
        format.xml  { render xml: @organization.to_xml }
      end
    end

    def index
      @organizations = Organization.all
      respond_to do |format|
        format.html { render }
        format.json { render json: @organizations.select(:id, :name, :view_count) }
      end
    end

    def edit
    end

    def update
        # @organization.slug = nil
        if @organization.update organization_params

          redirect_to organization_path(@organization), notice: "organization updated!"
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
    @organization = Organization.find params[:id]
  end

  def organization_params
    params.require(:organization).permit(:name, :address, :overview, :employee_count, :tech_team_size, :website, :twitter, :published, :user_id)
  end

  def authorize_organization
    redirect_to root_path unless can? :cru, @organization
  end

end
