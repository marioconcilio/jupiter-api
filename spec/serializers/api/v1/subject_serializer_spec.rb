require 'rails_helper'

module Api::V1
  describe 'Subject Serializer', :type => :serializer do

    describe 'attributes' do
      let(:subject) { FactoryGirl.build(:subject) }
      let!(:json) do
        serialized = SubjectSerializer.new(subject)
        serialization = ActiveModelSerializers::Adapter.create(serialized)
        JSON.parse(serialization.to_json)
      end

      it 'should have code that matches' do
        expect(json['code']).to eql(subject.code)
      end

      it 'should have name that matches' do
        expect(json['name']).to eql(subject.name)
      end

      it 'should show its classrooms' do
        expect(json['classrooms']).to be_truthy
      end

      it 'should not show its id' do
        expect(json['id']).to be_falsy
      end

      it 'should not show created_at' do
        expect(json['created_at']).to be_falsy
      end

      it 'should not show updated_at' do
        expect(json['updated_at']).to be_falsy
      end

    end
  end
end
