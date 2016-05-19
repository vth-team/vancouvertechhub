FactoryGirl.define do
  factory :organization do
    name {Faker::Company.name}
    address {Faker::Address.street_address}
    overview {Faker::Company.bs}
    employee_count {rand(10..100)}
    tech_team_size {rand(1..10)}
    website {Faker::Internet.url}
    twitter {Faker::Internet.domain_word }
    published false
  end

  factory :published_organization, class: Organization do
<<<<<<< HEAD
    name {Faker::Company.name}
    address {Faker::Address.street_address}
    overview {Faker::Company.bs}
    employee_count {rand(10..100)}
    tech_team_size {rand(1..10)}
    website {Faker::Internet.url}
    twitter {Faker::Internet.domain_word }
=======
    name "MyString"
    address "MyString"
    overview "MyText"
    employee_count 1
    tech_team_size 1
    website "MyString"
    twitter "MyString"
>>>>>>> Add FactoryGirls for an admin user and for an unpublished company, modify organization publish status rspec test accordingly
    published true
  end
end
