module Api::V1
  class ApiController < ApplicationController
    include Response

    before_action :destroy_session

    def destroy_session
      request.session_options[:skip] = true
    end
  end
end