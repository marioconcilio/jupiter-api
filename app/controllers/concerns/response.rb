module Response

  def json_response(object, status=200, error=nil)
    if object.nil?
      status = 404
      error = "Not Found"
    end

    render json: {status: status, error: error, data: object}, status: status
  end
  
end