require 'rails_helper'

describe Schedule, type: :model do

  # Schedule model belongs to a single Classroom
  it { should belong_to(:classroom) }

  it { should validate_presence_of(:week_day) }
  it { should validate_presence_of(:time_begin) }
  it { should validate_presence_of(:teachers) }
  it { should validate_presence_of(:classroom) }
end
