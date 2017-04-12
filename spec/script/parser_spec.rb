require 'rails_helper'
require_relative '../../script/parser.rb'

describe 'Parser' do

  context 'when parsing HEP0145' do
    let(:page) { Nokogiri::HTML(File.read('spec/fixtures/HEP0145.html')) }
    let(:tables) { tables = page.at('td[width="568"]').search('table') }

    context 'its classroom' do
      let(:classroom) { parse_classroom(table: tables[0], subject: nil) }

      it 'should have code that matches "201701"' do
        expect(classroom.code).to eql('2017101')
      end

      it 'should have date_begin that matches "13/03/2017"' do
        expect(classroom.date_begin).to eql(Date.new(2017, 3, 13))
      end

      it 'should have date_end that matches "03/07/2017"' do
        expect(classroom.date_end).to eql(Date.new(2017, 7, 3))
      end

      it 'should have kind that matches "Teórica"' do
        expect(classroom.kind).to eql('Teórica')
      end

      it 'should have empty notes' do
        expect(classroom.notes).to eql('')
      end

    end # its classroom

    context 'its schedule' do
      let(:schedule) { parse_schedule(table: tables[1], classroom: nil)[0] }

      it 'should have week_day that matches "seg"' do
        expect(schedule.week_day).to eql('seg')
      end

      it 'should have time_begin that matches "14:00"' do
        expect(schedule.time_begin.strftime("%H:%M")).to eql('14:00')
      end

      it 'should have time_end that matches "16:00"' do
        expect(schedule.time_end.strftime("%H:%M")).to eql('16:00')
      end

      it 'should have teachers that matches' do
        expect(schedule.teachers).to eql(
          ['(R)Alexandre Dias Porto Chiavegatto Filho',
          '(R)Francisco Chiaravalloti Neto'])
      end

    end # its schedule

  end # when parsing HEP0145

end # Parser
