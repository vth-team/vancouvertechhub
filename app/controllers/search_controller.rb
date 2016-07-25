class SearchController < ApplicationController

  # The organization_display.jsx react component sends an ajax request with the appropriate parameters
  def search
    @results = []
    if params[:term]
      @results.concat(Organization.where('name ILIKE ?', "%#{params[:term]}%"))
      @results.concat(Organization.search_in_overview(params[:term]))
    end
    if params[:size]
      if params[:size] == "1"
        @results.concat(Organization.where(tech_team_size: 1..25))
      elsif params[:size] == "2"
        @results.concat(Organization.where(tech_team_size: 26..50))
      elsif params[:size] == "3"
        @results.concat(Organization.where('tech_team_size > ?', 50))
      end
    end
    if params[:tech]
      # This gets the ids of the specified techs
      techs = params[:tech].split(' ').map{|x| x.to_i}
      org_ids = OrganizationTechnology.where(technology_id: techs).pluck('organization_id').uniq
      org_ids.each do |o|
        @results.concat(Organization.where(id: o))
      end
    end
    respond_to do |format|
      format.html { render json: @results }
      format.json { render json: @results }
    end
  end
end

