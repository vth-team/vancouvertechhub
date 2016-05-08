require 'net/http'
# require 'base64' # need this if you don't use searchbing gem

class NewsController < ApplicationController


  def index

    accountKey = ENV["bing_key"]
    @bing_news = Bing.new(accountKey, 100, 'News')
    # or optionally specify an offset for your search, to start retrieving results from the starting point provided
    @bing_news_search_results = @bing_news.search("vancouver tech", 0)
    @bing_news_total = @bing_news_search_results[0][:NewsTotal]
    @bing_news_results = @bing_news_search_results[0][:News]
    @bing_news_paginate = Kaminari.paginate_array(@bing_news_results).page(params[:page]).per(10)


    # without using searchbing gem
    # http://stackoverflow.com/questions/13660455/bing-search-api-in-ruby
    # url = "https://api.datamarket.azure.com/Bing/Search/v1/News?Query='Vancouver Tech'&$format=JSON"
    # #url = "https://api.datamarket.azure.com/Data.ashx/Bing/SearchWeb/v1/Web?Query=%27xbox%27&$top=50&$format=json"
    # uri = URI(url)
    #
    # req = Net::HTTP::Get.new(uri.request_uri)
    # #req.basic_auth '', accountKey
    # #encodedAccountKey = Base64.encode64(":" + accountKey)
    # #puts "encodedAccountKey = #{encodedAccountKey}"
    # req.basic_auth '', accountKey
    #
    # # Header being sent (the request object):
    # req.each_header do |header_name, header_value|
    #   puts "#{header_name} : #{header_value}"
    # end
    #
    # @res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https'){|http|
    #   http.request(req)
    # }
    # puts @res.body

  end

end
