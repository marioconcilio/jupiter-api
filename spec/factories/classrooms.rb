FactoryGirl.define do
  factory :classroom do
    code { Faker::Lorem.characters(7) }
    date_begin { Faker::Date.backward }
    date_end { Faker::Date.forward }
    kind { Faker::Lorem.word }
    subject_id nil
  end
end
