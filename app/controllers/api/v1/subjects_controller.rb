module Api::V1
  class SubjectsController < ApiController

    # GET /subjects
    def index
      subjects = Subject.includes(:classrooms, classrooms: [:schedules, :schools]).all
      subjects_response(subjects)
    end

    # GET /subjects/:id
    def show
      subject = Subject.includes(:classrooms, classrooms: [:schedules, :schools]).find_by(code: params[:id].upcase)
      subjects_response(subject)
    end

  end
end
