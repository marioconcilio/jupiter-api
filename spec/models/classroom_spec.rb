require 'rails_helper'

describe Classroom, type: :model do

  # Classroom model belongs to a single subject
  it { should belong_to(:subject) }

  # Classroom model has 1:m relationship with Schedule
  it { should have_many(:schedules).dependent(:destroy) }

  # Classroom model has 1:m relationship with School
  it { should have_many(:schools).dependent(:destroy) }

  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:date_begin) }
  it { should validate_presence_of(:date_end) }
  it { should validate_presence_of(:kind) }
  it { should validate_presence_of(:notes) }
  it { should validate_presence_of(:subject) }
end
