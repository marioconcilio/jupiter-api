require 'rails_helper'
require 'airborne'

module Api::V1
  describe 'Subjects API v1', type: :request do
    let!(:size) { rand 1..20 }
    let!(:subjects) { create_list(:subject, size) }

    describe 'GET /api/v1/subjects' do
      before { get '/api/v1/subjects' }

      it 'returns valid subjects' do
        expect_json_types 'subjects.*',
                          code: :string,
                          name: :string,
                          classrooms: :array_of_objects
      end

      it 'returns valid classrooms' do
        expect_json_types 'subjects.*.classrooms.*',
                          code: :string,
                          date_begin: :string,
                          date_end: :string,
                          kind: :string,
                          notes: :string
      end

      it 'returns valid schedules' do
        expect_json_types 'subjects.*.classrooms.*.schedules.*',
                          time_begin: :string,
                          time_end: :string,
                          week_day: :string,
                          teachers: :array_of_strings
      end

      it 'returns valid schools' do
        expect_json_types 'subjects.*.classrooms.*.schools.*',
                          name: :string,
                          kind: :string,
                          vacancies: :int,
                          inscribed: :int,
                          pending: :int,
                          enrolled: :int
      end

      it 'returns all subjects' do
        expect_json_sizes subjects: size
      end

      it 'returns content-type json' do
        expect_header 'Content-Type', 'application/json; charset=utf-8'
      end

      it 'returns status 200' do
        expect_status 200
      end

      it 'returns metadata OK' do
        expect_json 'status',
                    code: 200,
                    message: 'OK',
                    error: false
      end
    end # describe 'GET /api/v1/subjects'

    describe 'GET /api/v1/subjects/:code' do
      before { get "/api/v1/subjects/#{code}" }

      context 'when the subject exists' do
        let(:subject) { subjects.first }
        let(:code) { subject.code }

        it 'returns the subject' do
          expect_json 'subjects',
                      code: subject.code,
                      name: subject.name
        end

        it 'returns valid classrooms' do
          expect_json_types 'subjects.classrooms.*',
                            code: :string,
                            date_begin: :string,
                            date_end: :string,
                            kind: :string,
                            notes: :string
        end

        it 'returns valid schedules' do
          expect_json_types 'subjects.classrooms.*.schedules.*',
                            time_begin: :string,
                            time_end: :string,
                            week_day: :string,
                            teachers: :array_of_strings
        end

        it 'returns valid schools' do
          expect_json_types 'subjects.classrooms.*.schools.*',
                            name: :string,
                            kind: :string,
                            vacancies: :int,
                            inscribed: :int,
                            pending: :int,
                            enrolled: :int
        end

        it 'returns content-type json' do
          expect_header 'Content-Type', 'application/json; charset=utf-8'
        end

        it 'returns status 200' do
          expect_status 200
        end

        it 'returns metadata OK' do
        expect_json 'status',
                    code: 200,
                    message: 'OK',
                    error: false
        end
      end # context 'when the subject exists'

      context 'when the subject does not exist' do
        let(:code) { '10' }

        it 'returns content-type json' do
          expect_header 'Content-Type', 'application/json; charset=utf-8'
        end

        it 'returns status 404' do
          expect_status 404
        end

        it 'returns metadata Not Found' do
        expect_json 'status',
                    code: 404,
                    message: 'Not Found',
                    error: true
      end

      end # context 'when the subject does not exist'
    end # describe 'GET /api/v1/subjects/:id' do

  end # describe 'Subjects API v1'
end
