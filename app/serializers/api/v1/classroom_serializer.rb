class Api::V1::ClassroomSerializer < ActiveModel::Serializer
  attributes :code,
             :date_begin,
             :date_end,
             :kind,
             :notes,
             :schedules

  belongs_to :subject
  has_many :schedules
end
