module Response

  def json_response(object, status=200)
    if object.nil?
      status = 404
    end

    render json: {status_code: status, data: object}, status: status
  end
  
end