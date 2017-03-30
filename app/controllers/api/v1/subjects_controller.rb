module Api::V1
  class SubjectsController < ApiController

    # GET /subjects
    def index
      subjects = Subject.all
      subjects_response(subjects)
    end

    # GET /subjects/:id
    def show
      subject = Subject.find_by(code: params[:id].upcase)
      subjects_response(subject)
    end

  end
end
