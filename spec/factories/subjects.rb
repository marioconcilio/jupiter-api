FactoryGirl.define do
  factory :subject do
    code { Faker::Lorem.characters(7).upcase }
    name { Faker::Lorem.word }

    transient do
      classrooms_count { Faker::Number.between(1, 10) }
    end

    after :create do |subject, eval|
      create_list(:classroom, eval.classrooms_count, subject: subject)
    end
  end
end
