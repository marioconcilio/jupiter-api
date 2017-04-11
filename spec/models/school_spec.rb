require 'rails_helper'

describe School, type: :model do

  # School model belongs to a single Classroom
  it { should belong_to(:classroom) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:kind) }
  it { should validate_presence_of(:vacancies) }
  it { should validate_presence_of(:inscribed) }
  it { should validate_presence_of(:pending) }
  it { should validate_presence_of(:enrolled) }
end
