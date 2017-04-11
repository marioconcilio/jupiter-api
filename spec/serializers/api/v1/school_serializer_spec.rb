require 'rails_helper'

module Api::V1
  describe 'School Serializer', :type => :serializer do

    describe 'attributes' do
      let(:school) { FactoryGirl.build(:school) }
      let!(:json) do
        serialized = SchoolSerializer.new(school)
        serialization = ActiveModelSerializers::Adapter.create(serialized)
        JSON.parse(serialization.to_json)
      end

      it 'should have name that matches' do
        expect(json['name']).to eql(school.name)
      end

      it 'should have kind that matches' do
        expect(json['kind']).to eql(school.kind)
      end

      it 'should have vacancies that matches' do
        expect(json['vacancies']).to eql(school.vacancies)
      end

      it 'should have inscribed that matches' do
        expect(json['inscribed']).to eql(school.inscribed)
      end

      it 'should have pending that matches' do
        expect(json['pending']).to eql(school.pending)
      end

      it 'should have enrolled that matches' do
        expect(json['enrolled']).to eql(school.enrolled)
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

      it 'should not show its classroom_id' do
        expect(json['classroom_id']).to be_falsy
      end

    end
  end
end
