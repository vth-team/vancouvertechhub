# require 'net/http'
# require 'base64' # need this if you don't use searchbing gem

class NewsController < ApplicationController

  def index
    @articles = NewsArticle.where("created_at > ?", DateTime.now - 1.month).order("published_on DESC")
  end

  def string_search_terms
    @search_terms = []
    NewsFilter.all.each do |term|
      @search_terms.push("#{term.search_term}")
    end
  end

end
