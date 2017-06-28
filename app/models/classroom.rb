class Classroom < ApplicationRecord
  validates_presence_of :code,
                        :date_begin,
                        :date_end,
                        :kind,
                        :notes,
                        :subject

  has_many :schedules, dependent: :destroy
  has_many :schools, dependent: :destroy
  belongs_to :subject, optional: true
end
