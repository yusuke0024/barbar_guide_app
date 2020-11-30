FactoryBot.define do
  factory :user do
    name { 'yusuke' }
    sequence(:email) { |n| "exemple#{n}@mail.com" }
    password { 'foobar' }
    role { 0 }
  end
end
