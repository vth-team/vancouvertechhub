class NewsSearch
  def search(search_term)
    article_ids = []
    @news = GoogleCustomSearchApi.search("\"#{search_term}\"", page: 1)

    @news.items.each do |item|
      parser = ArticleParser.new(item)

      if parser.published_on
        article = NewsArticle.new parser.slice(:title, :snippet, :link, :thubmnail, :published_on)
      else
        Rails.logger = Logger.new(STDOUT)
        Rails.logger.info "Not a real article"
      end

      if article && article.save
        article_ids.push(article.id)
        Rails.logger.info "Article saved"
      else
        Rails.logger.info "Article not saved"
      end
    end
    return article_ids
  end
end
