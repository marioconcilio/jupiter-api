module Api::V1
  class SubjectsController < ApiController

    # GET /subjects
    def index
      subjects = Subject.all
      json_response(subjects) 
    end

    # GET /subjects/:id
    def show
      subject = Subject.find_by(code: params[:id].upcase)
      render json: subject, include: ['classrooms', 'classrooms.schedules']

      # json_response(subject)
    end

  end
end
