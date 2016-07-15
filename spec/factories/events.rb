FactoryGirl.define do
  factory :event do
    title "MyString"
    url "MyString"
    image File.open(File.join(Rails.root, 'spec/fixtures/rails.png'))
    amount 1
    effective_date Date.today
    expire_date Date.today
    state "有效"
  end
end