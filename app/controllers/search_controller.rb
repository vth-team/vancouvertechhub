class SearchController < ApplicationController

   # The organization_display.jsx react component sends an ajax request with the appropriate parameters
  def search
    if params[:term]
      term = Organization.where('name ILIKE ? OR overview ILIKE ?', "%#{params[:term]}%", "%#{params[:term]}%")
    end
    if params[:size]
      if params[:size] == "1"
        size = Organization.where(tech_team_size: 1..25)
      elsif params[:size] == "2"
        size = Organization.where(tech_team_size: 26..50)
      elsif params[:size] == "3"
        size = Organization.where('tech_team_size > ?', 50)
      else
        size = Organization.all
      end
    end
    if params[:tech] != ""
      tech = []
      # This gets the ids of the specified techs
      techs = params[:tech].split(' ').map{|x| x.to_i}
      org_ids = OrganizationTechnology.where(technology_id: techs).pluck('organization_id').uniq
      org_ids.each do |o|
        tech << (Organization.where(id: o))
      end
    else
      tech = Organization.all
    end
    @results = term & size & tech
    respond_to do |format|
      format.html { render json: @results }
      format.json { render json: @results }
    end
  end


end
