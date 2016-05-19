FactoryGirl.define do
  factory :news_article do
<<<<<<< ffdf1c0c5b301fffe63d519257ac40acafd15cf6
    sequence(:title) { |n| "#{Faker::Company.bs}-#{n}" }
    snippet          { Faker::Hipster.paragraph }
    link             { Faker::Internet.url }
    thumbnail        { Faker::Internet.url }
    published_on     { Time.now - rand(30).days }
=======
    sequence(:title) {|n| "#{Faker::Company.bs}-#{n}" }
    snippet             { Faker::Hipster.paragraph       }
    link             {Faker::Internet.url}
    thumbnail        {Faker::Internet.url}
    published_on      { Time.now - rand(30).days      }
>>>>>>> ignore dump.rdb
  end
end
