namespace :fetch_news do
  desc "Fetching news articles from google news"
  task :fetch_all => :environment do
    NewsFilter.all.each do |search_term|
      puts search_term.search_term

      @news = GoogleCustomSearchApi.search(search_term.search_term, page: 1)

      @news.items.each do |article|
        thumbnail = article.pagemap.try(:[], "cse_thumbnail").try(:first).try(:[], "src")
        link = article.pagemap.try(:[], "cse_link").try(:first).try(:[], "src")
        NewsArticle.create(title: article.htmlTitle, snippet: article.htmlSnippet, link: article.link, thumbnail: thumbnail)
      end
    end
  end
end
