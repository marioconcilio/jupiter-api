class Lecture
  include Comparable

  attr_reader :id, :name, :classrooms

  def initialize(attributes = [])
    raise ArgumentError if attributes.nil? or attributes.empty?

    @id = attributes[0]
    @name = attributes[1]
    @classrooms = []

    for c in attributes[2]
      @classrooms.push(Classroom.new(c))
    end
  end

  def <=>(other)
    id <=> other.id
  end

end
