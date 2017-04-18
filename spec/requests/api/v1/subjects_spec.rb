require 'rails_helper'

module Api::V1
  describe 'Subjects API v1', type: :request do
    # initialize test data
    let!(:subjects) { create_list(:subject, 3) }

    describe 'GET /api/v1/subjects' do
      before { get '/api/v1/subjects' }
      let(:json) { JSON.parse(response.body) }

      it 'returns all subjects' do
        expect(json['subjects'].size).to eq(3)
      end

      it 'verifies if each subject have at least one classroom' do
        json['subjects'].each do |subject|
          expect(subject['classrooms']).not_to be_empty
        end
      end

      it 'verifies if each classroom have at least one schedule' do
        json['subjects'].each do |subject|
          subject['classrooms'].each do |classroom|
            expect(classroom['schedules']).not_to be_empty
          end
        end
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns metadata OK' do
        expect(json['status'].size).to eq(3)
        expect(json['status']['code']).to eq(200)
        expect(json['status']['message']).to eq('OK')
        expect(json['status']['error']).to eq(false)
      end
    end # describe 'GET /api/v1/subjects'

    describe 'GET /api/v1/subjects/:id' do
      before { get "/api/v1/subjects/#{subject_code}" }
      let(:json) { JSON.parse(response.body) }

      context 'when the subject exists' do
        let(:subject) { subjects.first }
        let(:subject_code) { subject.code }

        it 'returns the subject' do
          expect(json['subjects']).not_to be_empty
          expect(json['subjects']['code']).to eq(subject.code)
          expect(json['subjects']['name']).to eq(subject.name)
        end

        it 'verifies if returned subject have at least one classroom' do
          expect(json['subjects']['classrooms']).not_to be_empty
        end

        it 'verifies if returned classrooms have at least one schedule' do
          json['subjects']['classrooms'].each do |classroom|
            expect(classroom['schedules']).not_to be_empty
          end
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end

        it 'returns metadata OK' do
          expect(json['status'].size).to eq(3)
          expect(json['status']['code']).to eq(200)
          expect(json['status']['message']).to eq('OK')
          expect(json['status']['error']).to eq(false)
        end
      end # context 'when the subject exists'

      context 'when the subject does not exist' do
        let(:subject_code) { '10' }

        it 'returns header status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns metadata Not Found' do
          expect(json['status'].size).to eq(3)
          expect(json['status']['code']).to eq(404)
          expect(json['status']['message']).to eq('Not Found')
          expect(json['status']['error']).to eq(true)
        end

      end # context 'when the subject does not exist'
    end # describe 'GET /api/v1/subjects/:id'

  end # describe 'Subjects API v1'
end # module
