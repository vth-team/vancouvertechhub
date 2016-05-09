class AdminController < ApplicationController

  def organizations
    @organizations = Organization.all.order("name")
  end

  def events
  end

  def news
  end

  def users
  end

  def technologies
    @technologies = Technology.order("name").all
    @technology = Technology.new
  end

end
