class Api::V1::ClassroomSerializer < ActiveModel::Serializer
  attributes :code,
             :date_begin,
             :date_end,
             :kind,
             :notes,
             :schedules

  has_many :schedules
  has_many :schools

  belongs_to :subject
end
