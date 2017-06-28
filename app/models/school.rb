class School < ApplicationRecord
  validates_presence_of :name,
                        :kind,
                        :vacancies,
                        :inscribed,
                        :pending,
                        :enrolled

  # belongs_to :classroom
end
