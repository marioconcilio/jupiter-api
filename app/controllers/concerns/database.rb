require 'json'
require 'lecture'

module Database

  def load_db(path)
    file = File.read(path)
    data_hash = JSON.parse(file)
    db = data_hash["TODOS"]

    lectures = []
    for l in db
      lectures.push(Lecture.new(l))
    end

    return lectures
  end

end