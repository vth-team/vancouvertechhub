class FetchNewsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    @status = false

    NewsFilter.all.each do |news_filter|
      begin
        search(news_filter.search_term)
      rescue => err
        logger.info(err.message)
      end
    end
    return @status
  end

  def search(search_term)
    news_search = NewsSearch.new
    news_search.search(search_term)
  end
end
