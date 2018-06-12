FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    confirmed_at { Time.zone.now }
    password "1qaz2wsx"
  end
end
