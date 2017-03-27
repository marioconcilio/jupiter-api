class Schedule
  include Comparable

  attr_reader :week_day, :time_begin, :time_end, :teachers

  def initialize(attributes = [])
    raise ArgumentError if attributes.nil? or attributes.empty?

    @week_day = attributes[0]
    @time_begin = attributes[1]
    @time_end = attributes[2]
    @teachers = attributes[3]
  end

  def <=>(other)
    [week_day, time_begin, time_end, teachers] <=> [other.week_day, other.time_begin, other.time_end, other.teachers]
  end

end