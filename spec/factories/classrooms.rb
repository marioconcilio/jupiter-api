FactoryGirl.define do
  factory :classroom do
    code { Faker::Lorem.characters(7).upcase }
    date_begin { Faker::Date.backward }
    date_end { Faker::Date.forward }
    kind { Faker::Lorem.word }
    notes { Faker::Lorem.sentence }

    transient do
      schedules_count { Faker::Number.between(1, 10) }
    end

    after :create do |classroom, eval|
      create_list(:schedule, eval.schedules_count, classroom: classroom)
    end
  end
end
