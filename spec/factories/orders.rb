FactoryGirl.define do
  factory :order do
    association :user
    association :event
    amount 1
    date "2016-07-15"
  end
end
