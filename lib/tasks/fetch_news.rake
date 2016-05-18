namespace :fetch_news do
  desc "Fetching news articles from google news"
  task :fetch_all => :environment do
    NewsFilter.all.each do |search_term|
      puts search_term.search_term

      @news = GoogleCustomSearchApi.search(search_term.search_term, page: 1)

      @news.items.each do |item|
        thumbnail = item.pagemap.try(:[], "cse_thumbnail").try(:first).try(:[], "src")
        link = item.pagemap.try(:[], "cse_link").try(:first).try(:[], "src")
        snippet = item.htmlSnippet
        published_on_string = /([^.?!;\u2026]+[.?!;\u2026]+)/.match(snippet)[0][0..-8]

        published_on = published_on_string.to_datetime rescue nil

        if published_on
          article = NewsArticle.new(title: item.htmlTitle, snippet: snippet, link: item.link, thumbnail: thumbnail, published_on: published_on)
        else
          puts "Not a real article"
        end

        # Matching '...' with regex
        # http://stackoverflow.com/questions/21357295/javascript-regex-cant-match-ellipsis
        puts /([^.?!;\u2026]+[.?!;\u2026]+)/.match(snippet)


        if article && article.save
          puts "article saved"
        else
          puts "article not saved"
        end
      end
    end
  end
end
