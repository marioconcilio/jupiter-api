require 'rails_helper'

describe 'Subjects API', type: :request do
  # initialize test data
  let!(:subjects) { create_list(:subject, 10) }

  describe 'GET /api/v1/subjects' do
    before { get '/api/v1/subjects' }
    let(:json) { JSON.parse(response.body) }

    it 'returns all subjects' do
      expect(json['subjects']).not_to be_empty
      expect(json['subjects'].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns mime data' do
      expect(json['status']).not_to be_empty
      expect(json['status'].size).to eq(3)
    end

    it 'returns mime status code 200' do
      expect(json['status']['code']).to eq(200)
    end

    it 'returns mime message OK' do
      expect(json['status']['message']).to eq('OK')
    end

    it 'returns mime error false' do
      expect(json['status']['error']).to eq(false)
    end

  end

  describe 'GET /api/v1/subjects/:id' do
    before { get "/api/v1/subjects/#{subject_code}" }
    let(:json) { JSON.parse(response.body) }

    context 'when the subject exists' do
      let(:subject_code) { subjects.first.code }

      it 'returns the subject' do
        expect(json['subjects']).not_to be_empty
        expect(json['subjects']['code']).to eq(subject_code)
      end

      it 'returns header status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns mime data' do
        expect(json['status']).not_to be_empty
        expect(json['status'].size).to eq(3)
      end

      it 'returns mime status code 200' do
        expect(json['status']['code']).to eq(200)
      end

      it 'returns mime message OK' do
        expect(json['status']['message']).to eq('OK')
      end

      it 'returns mime error false' do
        expect(json['status']['error']).to eq(false)
      end
    end

    context 'when the subject does not exist' do
      let(:subject_code) { '10' }

      it 'returns header status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns mime data' do
        expect(json['status']).not_to be_empty
        expect(json['status'].size).to eq(3)
      end

      it 'returns mime status code 404' do
        expect(json['status']['code']).to eq(404)
      end

      it 'returns mime message Not Found' do
        expect(json['status']['message']).to eq('Not Found')
      end

      it 'returns mime error true' do
        expect(json['status']['error']).to eq(true)
    end

    end
  end

end
