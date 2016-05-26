class FetchOrganizationNewsJob < ActiveJob::Base
  queue_as :default

  def perform(organization_name, organization_id)
    begin
      article_ids = search(organization_name)
      associate_that_fool(organization_id, article_ids)
    rescue => err
      logger.info(err.message)
    end
  end

  private

  def search(search_term)
    news_search = NewsSearch.new
    news_search.search(search_term)
  end

  def associate_that_fool(organization_id, article_ids)
    article_ids.each do |article_id|
      OrganizationNews.create(organization_id: organization_id, news_article_id: article_id)
    end
  end
end
