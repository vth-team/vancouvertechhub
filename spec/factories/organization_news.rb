FactoryGirl.define do
  factory :organization_news do
    association :organization, factory: :organization
    association :news_article, factory: :news_article
  end
end
