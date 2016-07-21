class SearchController < ApplicationController

  # The organization_display.jsx react component sends an ajax request with the appropriate parameters
  def search

    # param[:term] nil
    # param[:size] 0
    # param[:tech] nil
    respond_to do |format|
      format.json { render json: @results }
    end
  end
end
