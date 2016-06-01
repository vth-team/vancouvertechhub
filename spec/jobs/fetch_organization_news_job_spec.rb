require 'rails_helper'

RSpec.describe FetchOrganizationNewsJob, type: :job do
  subject(:job) { described_class.perform_later(123) }

  it 'queues the job' do
    expect { job }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end
end
