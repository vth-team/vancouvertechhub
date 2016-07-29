class Admin::TechnologiesController < Admin::BaseController

  def create
    @technology = Technology.new(technology_params)
    if @technology.save
      redirect_to admin_technologies_path, notice: "Technology Added"
    else
      redirect_to admin_technologies_path, alert: "Technology Not Added"
    end
  end

  def destroy
    @technology = Technology.find params[:id]
    if @technology.destroy
      redirect_to admin_technologies_path, notice: "Technology Removed"
    else
      redirect_to admin_technologies_path, alert: "Technology Not Removed"
    end
  end

  private

  def technology_params
    params.require(:technology).permit([:name])
  end

end
