class Admin::AdminController < Admin::BaseController

  def organizations
    @organizations = Organization.all.order("name")
  end

  def events
    @events = Event.order("start_time").all
    @event  = Event.new
  end

  def news_filters
    @news_filters = NewsFilter.order("search_term").all
    @news_filter = NewsFilter.new
  end

  def users
    @claims = ClaimRequest.all
    @users = User.all
    @user  = User.new
  end

  def technologies
    @technologies = Technology.order("name").all
    @technology   = Technology.new
  end

end
