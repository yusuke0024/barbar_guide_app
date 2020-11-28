FactoryBot.define do
  factory :user do
    name { "yusuke" }
    sequence(:email) { |n| "example#{n}@mail.com" }
    password { "foobar" }
  end
end
