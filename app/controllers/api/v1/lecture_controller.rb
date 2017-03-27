module Api::V1
  class LectureController < ApiController
    include Database

    # GET /api/v1/lecture/:id
    def show
      lectures = load_db('db/jupiterweb.json')
      lecture = lectures.detect{ |lec| lec.id == params[:id].upcase }
      json_response(lecture)
    end

  end
end