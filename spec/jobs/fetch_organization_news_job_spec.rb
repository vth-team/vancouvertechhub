require 'rails_helper'

RSpec.describe FetchOrganizationNewsJob, type: :job do
  it 'queues the job' do
    ActiveJob::Base.queue_adapter = :test
    expect{ FetchOrganizationNewsJob.perform_later }.to have_enqueued_job.on_queue("default")
  end
end
