require 'rails_helper'

module Api::V1
  describe 'Schedule Serializer', :type => :serializer do

    describe 'attributes' do
      let(:schedule) { FactoryGirl.build(:schedule) }
      let!(:json) do
        serialized = ScheduleSerializer.new(schedule)
        serialization = ActiveModelSerializers::Adapter.create(serialized)
        JSON.parse(serialization.to_json)
      end

      it 'should have week_day that matches' do
        expect(json['week_day']).to eql(schedule.week_day)
      end

      it 'should have time_begin that matches' do
        expect(json['time_begin']).to eql(schedule.time_begin.strftime('%H:%M:%SZ'))
      end

      it 'should have time_end that matches' do
        expect(json['time_end']).to eql(schedule.time_end.strftime('%H:%M:%SZ'))
      end

      it 'should have teachers that matches' do
        expect(json['teachers']).to eql(schedule.teachers)
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
