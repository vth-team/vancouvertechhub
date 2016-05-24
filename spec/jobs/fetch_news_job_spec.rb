require 'rails_helper'
RSpec.describe FetchNewsJob, type: :job do
  include ActiveJob::TestHelper
    subject(:job) { described_class.perform_later(123) }

    it 'queues the job' do
      expect { job }
      .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
    end

    describe "#perform"  do
      it "assigns a variable" do
        expect(assigns(:parser)).to be_a_new(ArticleParser)
      end

      it "adds a new article to the database" do
        count_before=NewsArticle.count

        count_after=NewsArticle.count

      end      
    end

end
