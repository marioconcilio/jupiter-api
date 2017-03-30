FactoryGirl.define do
  factory :schedule do
    week_day { Faker::Lorem.characters(3) }
    time_begin { Faker::Time.backward(:morning) }
    time_end { Faker::Time.backward(:evening) }
    teachers [Faker::Name.first_name, Faker::Name.first_name]
    classroom_id nil
  end
end
