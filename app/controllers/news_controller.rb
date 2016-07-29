class NewsController < ApplicationController
  def index
    @articles = NewsArticle.recent_news
  end
end
