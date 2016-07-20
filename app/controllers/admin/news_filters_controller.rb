class Admin::NewsFiltersController < Admin::BaseController

  def create
    @news_filter = NewsFilter.new(news_filter_params)
    if @news_filter.save
      redirect_to admin_news_filters_path, notice: "News Filter Added"
    else
      redirect_to admin_news_filters_path, alert: "News Filter Not Added"
    end
  end

  def destroy
    @news_filter = NewsFilter.find params[:id]
    if @news_filter.destroy
      redirect_to admin_news_filters_path, notice: "News Filter Removed"
    else
      redirect_to admin_news_filters_path, alert: "News Filter Not Removed"
    end
  end

  private

  def news_filter_params
    params.require(:news_filter).permit([:search_term])
  end

end
