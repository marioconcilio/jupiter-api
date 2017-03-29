class Subject < ApplicationRecord
  validates_presence_of :code, :name

  has_many :classrooms
end
