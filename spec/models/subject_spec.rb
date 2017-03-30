require 'rails_helper'

describe Subject, type: :model do

  # Subject model has 1:m relationship with Classroom
  it { should have_many(:classrooms) }

  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:name) }
end
