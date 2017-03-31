require 'rails_helper'

describe 'Subjects API', type: :request do
  # initialize test data
  let!(:subjects) { create_list(:subject, 10) }

  describe 'GET /api/v1/subjects' do
    before { get '/api/v1/subjects' }

    it 'returns subjects' do
      json = JSON.parse(response.body)
      puts JSON.pretty_generate(json)
      expect(json['subjects']).not_to be_empty
      expect(json['subjects'].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

  end

  describe 'GET /api/v1/subjects/:id' do
    before { get "/api/v1/subjects/#{subject_code}" }

    context 'when the subject exists' do
      let(:subject_code) { subjects.first.code }

      it 'returns the subject' do
        json = JSON.parse(response.body)
        expect(json['subjects']).not_to be_empty
        expect(json['subjects']['code']).to eq(subject_code)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the subject does not exist' do
      let(:subject_code) { '10' }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

end
