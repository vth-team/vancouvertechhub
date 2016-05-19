FactoryGirl.define do
  factory :organization do
    name "MyString"
    address "MyString"
    overview "MyText"
    employee_count 1
    tech_team_size 1
    website "MyString"
    twitter "MyString"
    published false
  end

  factory :published_organization, class: Organization do
    name "MyString"
    address "MyString"
    overview "MyText"
    employee_count 1
    tech_team_size 1
    website "MyString"
    twitter "MyString"
    published true
  end
end
