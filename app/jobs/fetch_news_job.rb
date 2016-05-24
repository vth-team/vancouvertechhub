class FetchNewsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    NewsFilter.all.each do |news_filter|
      begin
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
            Rails.logger.info "article saved"
          else
            Rails.logger.info "article not saved"
          end
        end
      rescue => err
        logger.info(err.message)
      end
    end
  end
end
