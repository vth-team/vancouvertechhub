namespace :fetch_organization_news do
  desc "Fetching news articles from google news that are specific for companies"
  task :fetch_all => :environment do
    FetchNewsJob.perform_later
  end
end
