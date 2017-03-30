FactoryGirl.define do
  factory :subject do
    code { Faker::Lorem.characters(7) }
    name { Faker::Lorem.word }
  end
end
