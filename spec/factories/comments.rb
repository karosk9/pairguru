FactoryBot.define do
  factory :comment do
    body "MyText"
    association :user
    association :movie
    created_at { Time.zone.now }
  end
end
