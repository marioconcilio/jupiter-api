module Response

  def json_response(object:, root:, includes:, status:, message:)
    if object.nil?
      render json: {status: {code: 404, message: 'Not Found', error: true}}, status: 404
    else
      render json: object,
             root: root,
             adapter: :json,
             include: includes,
             meta: {code: status, message: message, error: false},
             meta_key: 'status',
             status: 200
    end
  end

  def subjects_response(object, status=200, message='OK')
    json_response object: object,
                  root: 'subjects',
                  includes: 'classrooms.schedules',
                  status: status,
                  message: message
  end

end
