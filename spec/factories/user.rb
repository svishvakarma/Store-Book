FactoryBot.define do
  factory :user do
    email {Faker::Internet.email}
    password {'dfsdjfhsd23'}
  end
end