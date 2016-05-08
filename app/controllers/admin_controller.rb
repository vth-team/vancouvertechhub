class AdminController < ApplicationController

  def organizations
    @organizations = Organization.all
  end

  def events
  end

  def news
  end

  def users
  end

  def technologies
    @technologies = Technology.all
    @technology = Technology.new
  end

end
