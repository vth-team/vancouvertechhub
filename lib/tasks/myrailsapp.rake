namespace :myrailsapp do
  desc "Crawl daily meetup data"
	  task daily_meetup_crawl_job: :environment do
	   puts "Crawling daily meetup data..."
	   DailyMeetupCrawlJob.perform_now
	 end
end
