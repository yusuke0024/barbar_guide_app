FactoryBot.define do
  factory :review do
    comment { 'リラックスできて最高だった' }
    association :salon
    association :user
  end
end
