require 'json'

module Database

  def load_db(path)
    file = File.read(path)
    data_hash = JSON.parse(file)

    return data_hash["TODOS"]
  end

end