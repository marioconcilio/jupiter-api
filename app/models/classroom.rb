class Classroom
  include Comparable

  attr_reader :id, :date_begin, :date_end, :type, :schedules

  def initialize(attributes = [])
    raise ArgumentError if attributes.nil? or attributes.empty?

    @id = attributes[0]
    @date_begin = attributes[1]
    @date_end = attributes[2]
    @type = attributes[3]
    @schedules = []

    unless attributes[4].nil?
      for s in attributes[4]
        @schedules.push(Schedule.new(s))
      end
    end
    
  end

  def <=>(other)
    [id, date_begin, date_end, type, schedules] <=> [other.id, other.date_begin, other.date_end, other.type, other.schedules]
  end

end
