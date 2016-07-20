require 'rails_helper'

RSpec.describe FetchNewsJob, type: :job do
  include ActiveJob::TestHelper

  subject(:job) { described_class.perform_later(123) }

  it 'queues the job' do
    expect { job }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  describe "#perform" do

    it "adds a new article to the database" do
      NewsFilter.create(search_term: "Vancouver Tech")

      count_before = NewsArticle.count

      search_result_data = GoogleCustomSearchApi::ResponseData.new({items: [{"kind"=>"customsearch#result", "title"=>"Tech millionaire steps in to save Vancouver's historic Friedman House", "htmlTitle"=>"<b>Tech</b> millionaire steps in to save <b>Vancouver&#39;s</b> historic Friedman House", "link"=>"http://www.theglobeandmail.com/real-estate/the-market/tech-millionaire-steps-in-to-save-vancouvers-historic-friedmanhouse/article29889813/", "displayLink"=>"www.theglobeandmail.com", "snippet"=>"May 10, 2016 ... It's a rare event when a historically important house on Vancouver's ... out getting \ninvolved in Vancouver's tech community in some capacity.", "htmlSnippet"=>"May 10, 2016 <b>...</b> It&#39;s a rare event when a historically important house on <b>Vancouver&#39;s</b> ... out getting <br>\ninvolved in <b>Vancouver&#39;s tech</b> community in some capacity.", "formattedUrl"=>"www.theglobeandmail.com/.../tech...vancouvers.../article29889813/", "htmlFormattedUrl"=>"www.theglobeandmail.com/.../<b>tech</b>...<b>vancouvers</b>.../article29889813/", "pagemap"=>{"cse_thumbnail"=>[{"width"=>"299", "height"=>"168", "src"=>"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKnKT3aCJAClJ0UrR8QvIIrnIqIcQP_jpe31H2HEOpEHYgOWGDMK14NXGD"}], "imageobject"=>[{"url"=>"http://static.theglobeandmail.ca/72f/incoming/article29888966.ece/ALTERNATES/w940/ID1407389690.jpg", "width"=>"940", "height"=>"529"}, {"url"=>"http://beta.images.theglobeandmail.com/media/www/images/flag/gam-masthead.png", "width"=>"310", "height"=>"36"}], "organization"=>[{"name"=>"The Globe and Mail", "sameas"=>"http://www.theglobeandmail.com/"}], "metatags"=>[{"identifier-url"=>"http://www.theglobeandmail.com", "viewport"=>"width=device-width", "location"=>"Canada", "website"=>"http://www.theglobeandmail.com", "application-artifactid"=>"gam-webapp", "application-version"=>"14.0.333", "application-contextname"=>"globeandmail", "last-modified"=>"2016-05-10 12:07:07 EDT", "article:id"=>"29889813", "article:type"=>"enriched", "article:comments"=>"false", "article:engagement"=>"true", "article:pages"=>"1", "article:onpage"=>"1", "apple-itunes-app"=>"app-id=429228415", "fb:app_id"=>"126045934076200", "twitter:account_id"=>"1512948019", "og:site_name"=>"The Globe and Mail", "og:title"=>"Tech millionaire steps in to save Vancouver’s historic Friedman House", "og:url"=>"http://www.theglobeandmail.com/real-estate/the-market/tech-millionaire-steps-in-to-save-vancouvers-historic-friedmanhouse/article29889813/", "og:description"=>"Mid-century modern home in University Endowment Lands had been targeted for demolition", "og:type"=>"article", "og:image"=>"http://static.theglobeandmail.ca/060/incoming/article29888966.ece/ALTERNATES/w620/ID1407389690.jpg", "og:image:secure_url"=>"https://sec.images.theglobeandmail.com/media/www/images/flag/gam-square.png", "og:image:type"=>"image/png", "og:image:width"=>"400", "og:image:height"=>"400", "twitter:card"=>"app", "twitter:site"=>"@globeandmail", "twitter:description"=>"Mid-century modern home in University Endowment Lands had been targeted for demolition", "twitter:app:country"=>"CA", "twitter:app:name:iphone"=>"The Globe And Mail", "twitter:app:name:ipad"=>"The Globe And Mail", "twitter:app:id:iphone"=>"429228415", "twitter:app:id:ipad"=>"429228415", "twitter:app:url:iphone"=>"tgam://article/29889813", "twitter:app:url:ipad"=>"tgam://article/29889813"}], "cse_image"=>[{"src"=>"http://static.theglobeandmail.ca/060/incoming/article29888966.ece/ALTERNATES/w620/ID1407389690.jpg"}], "newsarticle"=>[{"mainentityofpage"=>"http://www.theglobeandmail.com/real-estate/the-market/tech-millionaire-steps-in-to-save-vancouvers-historic-friedmanhouse/article29889813/", "headline"=>"Tech millionaire steps in to save Vancouver’s historic Friedman House", "name"=>"Tech millionaire steps in to save Vancouver’s historic Friedman House", "dateline"=>"Vancouver", "sourceorganization"=>"The Globe and Mail", "datepublished"=>"2016-05-05T14:05:37EDT", "datemodified"=>"2016-05-10T12:05:07EDT", "articlebody"=>"It’s a rare event when a historically important house on Vancouver’s west side is saved from the bulldozer, but this past week, it happened. In response to a recent Globe story, an Ottawa..."}]}}]})
      allow(GoogleCustomSearchApi).to receive(:search).and_return(search_result_data)

      FetchNewsJob.perform_now

      count_after = NewsArticle.count

      expect(count_after).to eq(count_before + 1)
    end
  end
end
