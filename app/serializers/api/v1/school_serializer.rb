class Api::V1::SchoolSerializer < ActiveModel::Serializer
  attributes :name,
             :kind,
             :vacancies,
             :inscribed,
             :pending,
             :enrolled

  belongs_to :classroom
end
