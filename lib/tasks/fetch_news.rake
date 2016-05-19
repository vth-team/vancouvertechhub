namespace :fetch_news do
  desc "Fetching news articles from google news"
  task :fetch_all => :environment do
    FetchNewsJob.perform_later
  end
end
