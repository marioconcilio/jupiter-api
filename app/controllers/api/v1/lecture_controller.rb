module Api::V1
  require 'lecture'

  class LectureController < ApiController
    include Database

    # GET /api/v1/lecture/:id
    def show
      db = load_db('db/jupiterweb.json')
      lectures = []
      for l in db
        lectures.push(Lecture.new(l))
      end

      lecture = lectures.detect{ |l|  l.id == params[:id].upcase }
      json_response(lecture)
    end

  end
end