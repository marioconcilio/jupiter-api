class Api::V1::ScheduleSerializer < ActiveModel::Serializer
  attributes :week_day, :time_begin, :time_end, :teachers
end
