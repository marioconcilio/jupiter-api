FactoryGirl.define do
  factory :schedule do
    classroom
    week_day { Faker::Lorem.characters(3) }
    time_begin { Faker::Time.backward(0, :morning).strftime('%H:%M') }
    time_end { Faker::Time.backward(0, :evening).strftime('%H:%M') }
    teachers { [Faker::Name.name_with_middle, Faker::Name.name_with_middle] }
  end
end
