FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name}
    last_name { Faker::Name.last_name}
    sequence(:email) { |n| Faker::Internet.email.gsub("@", "-#{n}@")}
    password  { Faker::Internet.password}
    admin false
    activated false
  end
  
  factory :admin, class: User do
    first_name { Faker::Name.first_name}
    last_name { Faker::Name.last_name}
    sequence(:email) { |n| Faker::Internet.email.gsub("@", "-#{n}@")}
    password  { Faker::Internet.password}
    admin true
    activated false
  end
end
