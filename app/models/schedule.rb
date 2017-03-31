class Schedule < ApplicationRecord
  validates_presence_of :week_day,
                        :time_begin,
                        :teachers,
                        :classroom

  belongs_to :classroom
end
