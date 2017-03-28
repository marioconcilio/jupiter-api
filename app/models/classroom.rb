class Classroom < ApplicationRecord
  validates_presence_of :date_begin, :date_end, :kind

  has_many :schedules
  belongs_to :subject, optional: true
end
