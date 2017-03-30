class Api::V1::SubjectSerializer < ActiveModel::Serializer
  attributes :code, 
             :name, 
             :classrooms

  has_many :classrooms
end
