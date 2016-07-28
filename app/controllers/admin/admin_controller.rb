<<<<<<< 674f75c3f95751656362d15f2961eb27accd1b7e:app/controllers/admin/admin_controller.rb
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

  def claims
    @claims = ClaimRequest.all
  end

end
=======
>>>>>>> test:app/controllers/admin_controller.rb
