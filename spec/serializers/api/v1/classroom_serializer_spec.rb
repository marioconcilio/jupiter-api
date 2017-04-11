require 'rails_helper'

module Api::V1
  describe 'Classroom Serializer', :type => :serializer do

    describe 'attributes' do
      let(:classroom) { FactoryGirl.build(:classroom) }
      let!(:json) do
        serialized = ClassroomSerializer.new(classroom)
        serialization = ActiveModelSerializers::Adapter.create(serialized)
        JSON.parse(serialization.to_json)
      end

      it 'should have code that matches' do
        expect(json['code']).to eql(classroom.code)
      end

      it 'should have date_begin that matches' do
        expect(json['date_begin']).to eql(classroom.date_begin.strftime('%Y-%m-%d'))
      end

      it 'should have date_end that matches' do
        expect(json['date_end']).to eql(classroom.date_end.strftime('%Y-%m-%d'))
      end

      it 'should have kind that matches' do
        expect(json['kind']).to eql(classroom.kind)
      end

      it 'should have notes that matches' do
        expect(json['notes']).to eql(classroom.notes)
      end

      it 'should show its schedules' do
        expect(json['schedules']).to be_truthy
      end

      it 'should show its schools' do
        expect(json['schools']).to be_truthy
      end

      it 'should not show created_at' do
        expect(json['created_at']).to be_falsy
      end

      it 'should not show updated_at' do
        expect(json['updated_at']).to be_falsy
      end

      it 'should not show its id' do
        expect(json['id']).to be_falsy
      end

      it 'should not show its subject_id' do
        expect(json['classroom_id']).to be_falsy
      end

    end
  end
end
