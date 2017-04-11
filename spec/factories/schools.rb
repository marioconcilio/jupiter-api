FactoryGirl.define do
  factory :school do
    name { Faker::University.name }
    kind { Faker::Lorem.word }
    vacancies { Faker::Number.between(0, 100) }
    inscribed { Faker::Number.between(0, 100) }
    pending { Faker::Number.between(0, 100) }
    enrolled { Faker::Number.between(0, 100) }
  end
end
