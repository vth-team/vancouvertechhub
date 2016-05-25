require 'rails_helper'

RSpec.describe ArticleParser do

  describe "htmlTitle" do
    context 'when news_item responds to #htmlTitle' do
      it 'returns the value of #htmlTitle' do
        news_item = double('NewsItem')
        allow(news_item).to receive(:htmlTitle).and_return('expected_title')
        # can also receive a block
        # allow(news_item).to receive(:htmlTitle) { 'expected_title' }
        # an alternative short form
        # news_item = double('NewsItem', htmlTitle: 'expected_title')

        parser = ArticleParser.new(news_item)

        expect(parser.htmlTitle).to eq('expected_title')
      end
    end

    context 'when news_item does not respond to #htmlTitle' do
      it 'raises NoMethodError' do
        # pass in an empty hash as news_item, if we pass in a double instead
        # then we will get a MockExpectationError
        news_item = {}

        parser = ArticleParser.new(news_item)

        expect { parser.htmlTitle }.to raise_error(NoMethodError)
      end
    end
  end

  describe "snippet" do
    context 'when news_item responds to #snippet' do
      it 'returns the value of #snippet' do
        news_item = double('NewsItem')
        expected_title = "Mar 2, 2016 <b>...</b> Fidelity wrote down its investment in social media marketing company Hootsuite <br>\nby 18%, a sign that lowered U.S. investor expectations are&nbsp;..."

        allow(news_item).to receive(:snippet).and_return(expected_title)

        parser = ArticleParser.new(news_item)

        expect(parser.snippet).to eq("Mar 2, 2016 <b>...</b> Fidelity wrote down its investment in social media marketing company Hootsuite <br>\nby 18%, a sign that lowered U.S. investor expectations are&nbsp;...")
      end
    end

    context 'when news_item does not respond to #snippet' do
      it 'raises NoMethodError' do
        # pass in an empty hash as news_item, if we pass in a double instead
        # then we will get a MockExpectationError
        news_item = {}

        parser = ArticleParser.new(news_item)

        expect { parser.snippet }.to raise_error(NoMethodError)
      end
    end
  end

  describe "thumbnail" do
    context 'when news_item responds to #thumbnail' do
      it 'returns the value of #thumbnail with a src' do
        THUMBNAIL_LINK = 'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcRkK6sGvVXZgE6pdn6THj5PyHa07hGnH4uelptZXHLsSnA3m7jGUq91oBqZ'
        news_item = double('NewsItem')
        #allow(news_item).to receive(:pagemap).and_return('expected_title')
        allow(news_item).to receive(:pagemap).and_return("cse_thumbnail"=>[{"width"=>"259", "height"=>"194", "src"=>THUMBNAIL_LINK}])

        parser = ArticleParser.new(news_item)

        expect(parser.thumbnail).to eq(THUMBNAIL_LINK)
      end
    end

    context 'when news_item does not respond to #thumbnail' do
      it 'raises NoMethodError' do
        # pass in an empty hash as news_item, if we pass in a double instead
        # then we will get a MockExpectationError
        news_item = {}

        parser = ArticleParser.new(news_item)

        expect { parser.thumbnail }.to raise_error(NoMethodError)
      end
    end
  end

  describe "link" do
    context 'when news_item responds to #link' do
      it 'returns the value of #link' do
        news_item = double('NewsItem')
        #allow(news_item).to receive(:pagemap).and_return('expected_title')
        NEWS_ITEM_LINK="http://www.theguardian.com/environment/2016/may/05/elon-musk-we-need-a-revolt-against-the-fossil-fuel-industry"
        allow(news_item).to receive(:link).and_return(NEWS_ITEM_LINK)

        parser = ArticleParser.new(news_item)
        expect(parser.link).to eq(NEWS_ITEM_LINK)
      end
    end

    context 'when news_item does not respond to #link' do
      it 'raises NoMethodError' do
        # pass in an empty hash as news_item, if we pass in a double instead
        # then we will get a MockExpectationError
        news_item = {}

        parser = ArticleParser.new(news_item)

        expect { parser.link }.to raise_error(NoMethodError)
      end
    end
  end

  describe "published_on" do
    context 'when news_item responds to #published_on' do
      it 'returns the value of #published_on if snippet in the returned JSON contains a date' do
        news_item = double('NewsItem')
        #allow(news_item).to receive(:pagemap).and_return('expected_title')
        allow(news_item).to receive(:snippet).and_return("Mar 2, 2016 <b>...</b> Fidelity wrote down its investment in social media marketing company Hootsuite <br>\nby 18%, a sign that lowered U.S. investor expectations are&nbsp;...")

        parser = ArticleParser.new(news_item)

        expect(parser.published_on).to eq("Mar 2, 2016".to_datetime)
      end
    end

    it 'returns nil if snippet in the returned JSON does not contain a date' do
      news_item = double('NewsItem')
      #allow(news_item).to receive(:pagemap).and_return('expected_title')
      allow(news_item).to receive(:snippet).and_return("Read the latest <b>technology</b> news, trends, business coverage, gadgets, <br>\nelectronics, reviews and ... Grade Six girls from North <b>Vancouver</b> create Hike <br>\nSafe app.")

      parser = ArticleParser.new(news_item)

      expect(parser.published_on).to eq(nil)
    end

    context 'when news_item does not respond to #thumbnail' do
      it 'raises NoMethodError' do
        # pass in an empty hash as news_item, if we pass in a double instead
        # then we will get a MockExpectationError
        news_item = {}

        parser = ArticleParser.new(news_item)

        expect { parser.published_on }.to raise_error(NoMethodError)
      end
    end
  end
end
