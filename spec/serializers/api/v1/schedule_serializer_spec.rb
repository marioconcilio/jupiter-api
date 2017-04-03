require 'rails_helper'

module Api::V1
  describe 'Schedule Serializer', :type => :serializer do

    describe 'attributes' do
      # let(:serialized) { serialize(FactoryGirl.build(:schedule)) }
      let(:serialization) do
        schedule = FactoryGirl.build(:schedule)
        serialized = ScheduleSerializer.new(schedule)
        ActiveModelSerializers::Adapter.create(serialized)
      end

      subject { JSON.parse(serialization.to_json) }

      it 'should contain' do
        puts subject.to_json
      end
    end

  end
end
