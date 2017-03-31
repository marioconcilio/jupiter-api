FactoryGirl.define do
  factory :schedule do
    classroom
    week_day { Faker::Lorem.characters(3) }
    time_begin { '00:00' }
    time_end { 1235 }
    teachers { [Faker::Name.name_with_middle, Faker::Name.name_with_middle] }
  end
end
