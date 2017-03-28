class Schedule < ApplicationRecord
  validates_presence_of :week_day, :time_begin, :time_end, :teachers

  belongs_to :classroom
end
