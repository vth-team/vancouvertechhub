FactoryGirl.define do
  factory :news_article do
    sequence(:title) {|n| "#{Faker::Company.bs}-#{n}"}
    snippet             { Faker::Hipster.paragraph}
    link             {Faker::Internet.url}
    thumbnail        {Faker::Internet.url}
    published_on      { Time.now - rand(30).days}
  end
end
