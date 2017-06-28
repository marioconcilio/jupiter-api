class Api::V1::ScheduleSerializer < ActiveModel::Serializer
  attributes :week_day,
             :time_begin,
             :time_end,
             :teachers

  # belongs_to :classroom

  def time_begin
    object.time_begin.strftime("%H:%M:%SZ")
  end

  def time_end
    object.time_end.strftime("%H:%M:%SZ")
  end
end
