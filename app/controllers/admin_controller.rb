class AdminController < ApplicationController

  def organizations
    @organizations = Organization.all.order("name")
  end

  def events
  end

  def news_filters
    @news_filters = NewsFilter.order("search_term").all
    @news_filter = NewsFilter.new
  end

  def users
  end

  def technologies
    @technologies = Technology.order("name").all
    @technology = Technology.new
  end

end
