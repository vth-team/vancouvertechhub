class FetchNewsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    @status = false
    NewsFilter.all.each do |news_filter|
      begin
        search(news_filter)
      rescue => err
        logger.info(err.message)
      end
    end
    return @status
  end

  def search(news_filter)
    @news = GoogleCustomSearchApi.search(news_filter.search_term, page: 1)
    @news.items.each do |item|
      parser = ArticleParser.new(item)

      if parser.published_on
        article = NewsArticle.new(
          title: parser.htmlTitle,
          snippet: parser.htmlSnippet,
          link: parser.link,
          thumbnail: parser.thumbnail,
          published_on: parser.published_on
        )
      else
        Rails.logger = Logger.new(STDOUT)
        Rails.logger.info "Not a real article"
      end
      if article && article.save
        @status = true
        Rails.logger.info "article saved"
      else
        @status = false
        Rails.logger.info "article not saved"
      end
    end
  end
end
