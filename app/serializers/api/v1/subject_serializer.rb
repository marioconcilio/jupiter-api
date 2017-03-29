class Api::V1::SubjectSerializer < ActiveModel::Serializer
  attributes :id, 
             :code, 
             :name, 
             :classrooms

  has_many :classrooms
end
