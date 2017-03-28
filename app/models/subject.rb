class Subject < ApplicationRecord
  validates_presence_of :name

  has_many :classrooms
end
