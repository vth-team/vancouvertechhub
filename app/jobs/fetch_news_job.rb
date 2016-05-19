class FetchNewsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
    NewsFilter.all.each do |search_term|
      puts search_term.search_term

      @news = GoogleCustomSearchApi.search(search_term.search_term, page: 1)
      @news.items.each do |item|
        #byebug
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
          puts "Not a real article"
        end


        if article && article.save
          puts "article saved"
        else
          puts "article not saved"
        end
      end
    end

  end
end
