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
    name {Faker::Company.name}
    address {Faker::Address.street_address}
    overview {Faker::Company.bs}
    employee_count {rand(10..100)}
    tech_team_size {rand(1..10)}
    website {Faker::Internet.url}
    twitter {Faker::Internet.domain_word }
    published true
  end
end
