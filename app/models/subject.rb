class Subject < ApplicationRecord
  validates_presence_of :name, :code

  has_many :classrooms
end
