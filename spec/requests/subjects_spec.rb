require 'rails_helper'

describe 'Subjects API', type: :request do
  # initialize test data
  let!(:subjects) { create_list(:subject, 10) }
  let(:subject_id) { subjects.fist.id }

  describe 'GET /subjects' do
    before get '/subjects'

    it 'returns subjects' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

  end
end
