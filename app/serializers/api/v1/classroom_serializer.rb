class Api::V1::ClassroomSerializer < ActiveModel::Serializer
  attributes :code, :date_begin, :date_end, :kind, :schedules
  has_many :schedules
end
