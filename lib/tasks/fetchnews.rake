namespace :fetch_news do
  desc "Fetching news articles from google news"
  task :fetch_all => :environment do
    # use perform_now in devtest for debugging task with byebug
    # FetchNewsJob.perform_now
    # use perform_later in production
    FetchNewsJob.perform_later
  end
end
