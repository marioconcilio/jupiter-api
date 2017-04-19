require 'rails_helper'
require_relative '../../script/parser.rb'

RSpec.configure do |c|
  c.include Parser
end

describe Parser do
  context 'when parsing page' do
    let(:page) do
      parse_page page: Nokogiri::HTML(File.read('spec/fixtures/ABC0123.html')),
                 code: 'ABC0123',
                 name: 'Testecultura'
    end

    context 'its subject' do
      let(:subject) { page.subject }

      it 'should have code that matches' do
        expect(subject.code).to eql('ABC0123')
      end

      it 'should have name that matches' do
        expect(subject.name).to eql('Testecultura')
      end
    end # its subject

    context 'its first classroom' do
      let(:classroom) { page.classrooms[0] }

      it 'should have code that matches' do
        expect(classroom.code).to eql('2017101')
      end

      it 'should have date_begin that matches' do
        expect(classroom.date_begin).to eql(Date.new(2017, 3, 6))
      end

      it 'should have date_end that matches' do
        expect(classroom.date_end).to eql(Date.new(2017, 7, 8))
      end

      it 'should have kind that matches' do
        expect(classroom.kind).to eql('Teórica e Prática')
      end

      it 'should not have notes' do
        expect(classroom.notes).to be_nil
      end

      context 'schedule' do
        let(:schedules) { page.schedules[0] }

        it 'should have two entries' do
          expect(schedules.count).to eql(2)
        end

        context 'first entry' do
          let(:schedule) { schedules[0] }

          it 'should have week_day that matches' do
            expect(schedule.week_day).to eql('ter')
          end

          it 'should have time_begin that matches' do
            expect(schedule.time_begin).to eql(Time.zone.parse('14:00').utc)
          end

          it 'should have time_end that matches' do
            expect(schedule.time_end).to eql(Time.zone.parse('17:50').utc)
          end

          it 'should have teachers that matches' do
            expect(schedule.teachers).to eql(['(R)Obi-Wan Kenobi'])
          end
        end # first entry

        context 'second entry' do
          let(:schedule) { schedules[1] }

          it 'should have week_day that matches' do
            expect(schedule.week_day).to eql('qui')
          end

          it 'should have time_begin that matches' do
            expect(schedule.time_begin).to eql(Time.zone.parse('16:00').utc)
          end

          it 'should have time_end that matches' do
            expect(schedule.time_end).to eql(Time.zone.parse('18:50').utc)
          end

          it 'should have teachers that matches' do
            expect(schedule.teachers).to eql(['Soon Qui-Gon'])
          end
        end # second entry

      end # schedule

      context 'schools' do
        let(:schools) { page.schools[0] }

        it 'should have seven entries' do
          expect(schools.count).to eql(7)
        end

        context 'first entry' do
          let(:school) { schools[0] }

          it 'should have kind that matches' do
            expect(school.kind).to eql('Obrigatória')
          end

          it 'should have name that matches' do
            expect(school.name).to eql('')
          end

          it 'should have data that matches' do
            expect(school.vacancies).to eql(0)
            expect(school.inscribed).to eql(0)
            expect(school.pending).to eql(0)
            expect(school.enrolled).to eql(0)
          end
        end # first entry

        context 'second entry' do
          let(:school) { schools[1] }

          it 'should have kind that matches' do
            expect(school.kind).to eql('Optativa Eletiva')
          end

          it 'should have name that matches' do
            expect(school.name).to eql('')
          end

          it 'should have data that matches' do
            expect(school.vacancies).to eql(45)
            expect(school.inscribed).to eql(11)
            expect(school.pending).to eql(0)
            expect(school.enrolled).to eql(11)
          end
        end # second entry

        context 'third entry' do
          let(:school) { schools[2] }

          it 'should have kind that matches' do
            expect(school.kind).to eql('Optativa Livre')
          end

          it 'should have name that matches' do
            expect(school.name).to eql('Qualquer Unidade da USP')
          end

          it 'should have data that matches' do
            expect(school.vacancies).to eql(0)
            expect(school.inscribed).to eql(0)
            expect(school.pending).to eql(0)
            expect(school.enrolled).to eql(0)
          end
        end # third entry

        context 'fourth entry' do
          let(:school) { schools[3] }

          it 'should have kind that matches' do
            expect(school.kind).to eql('Optativa Livre')
          end

          it 'should have name that matches' do
            expect(school.name).to eql('ESALQ - Ciências Econômicas')
          end

          it 'should have data that matches' do
            expect(school.vacancies).to eql(5)
            expect(school.inscribed).to eql(0)
            expect(school.pending).to eql(0)
            expect(school.enrolled).to eql(0)
          end
        end # fourth entry

        context 'fifth entry' do
          let(:school) { schools[4] }

          it 'should have kind that matches' do
            expect(school.kind).to eql('Optativa Livre')
          end

          it 'should have name that matches' do
            expect(school.name).to eql('ESALQ - Ciências dos Alimentos')
          end

          it 'should have data that matches' do
            expect(school.vacancies).to eql(5)
            expect(school.inscribed).to eql(0)
            expect(school.pending).to eql(0)
            expect(school.enrolled).to eql(0)
          end
        end # fifth entry

        context 'sixth entry' do
          let(:school) { schools[5] }

          it 'should have kind that matches' do
            expect(school.kind).to eql('Alunos Especiais')
          end

          it 'should have name that matches' do
            expect(school.name).to eql('')
          end

          it 'should have data that matches' do
            expect(school.vacancies).to eql(1)
            expect(school.inscribed).to eql(0)
            expect(school.pending).to eql(0)
            expect(school.enrolled).to eql(0)
          end
        end # sixth entry

        context 'seventh entry' do
          let(:school) { schools[6] }

          it 'should have kind that matches' do
            expect(school.kind).to eql('Extracurricular')
          end

          it 'should have name that matches' do
            expect(school.name).to eql('')
          end

          it 'should have data that matches' do
            expect(school.vacancies).to eql(1)
            expect(school.inscribed).to eql(1)
            expect(school.pending).to eql(0)
            expect(school.enrolled).to eql(1)
          end
        end # seventh entry

      end # schools
    end # its first classroom

    context 'its second classroom' do
      let(:classroom) { page.classrooms[1] }

      it 'should have code that matches' do
        expect(classroom.code).to eql('2017102')
      end

      it 'should have date_begin that matches' do
        expect(classroom.date_begin).to eql(Date.new(2017, 2, 22))
      end

      it 'should have date_end that matches' do
        expect(classroom.date_end).to eql(Date.new(2017, 5, 24))
      end

      it 'should have kind that matches' do
        expect(classroom.kind).to eql('Teórica')
      end

      it 'should have notes that matches' do
        expect(classroom.notes).to eql('Sala 108')
      end

      context 'schedule' do
        let(:schedules) { page.schedules[1] }

        it 'should have one single entry' do
          expect(schedules.count).to eql(1)
        end

        context 'single entry' do
          let(:schedule) { schedules[0] }

          it 'should have week_day that matches' do
            expect(schedule.week_day).to eql('qua')
          end

          it 'should have time_begin that matches' do
            expect(schedule.time_begin).to eql(Time.zone.parse('14:00').utc)
          end

          it 'should have time_end that matches' do
            expect(schedule.time_end).to eql(Time.zone.parse('18:00').utc)
          end

          it 'should have teachers that matches' do
            expect(schedule.teachers).to eql(['(R)Anakin Skywalker', '(R)Mace Windu'])
          end
        end # single entry
      end # schedule

      context 'schools' do
        let(:schools) { page.schools[1] }

        it 'should have four entries' do
          expect(schools.count).to eql(4)
        end

        context 'first entry' do
          let(:school) { schools[0] }

          it 'should have kind that matches' do
            expect(school.kind).to eql('Obrigatória')
          end

          it 'should have name that matches' do
            expect(school.name).to eql('')
          end

          it 'should have data that matches' do
            expect(school.vacancies).to eql(0)
            expect(school.inscribed).to eql(0)
            expect(school.pending).to eql(0)
            expect(school.enrolled).to eql(0)
          end
        end # first entry

        context 'second entry' do
          let(:school) { schools[1] }

          it 'should have kind that matches' do
            expect(school.kind).to eql('Optativa Eletiva')
          end

          it 'should have name that matches' do
            expect(school.name).to eql('FSP - Saúde Pública')
          end

          it 'should have data that matches' do
            expect(school.vacancies).to eql(25)
            expect(school.inscribed).to eql(0)
            expect(school.pending).to eql(0)
            expect(school.enrolled).to eql(0)
          end
        end # second entry

        context 'third entry' do
          let(:school) { schools[2] }

          it 'should have kind that matches' do
            expect(school.kind).to eql('Optativa Livre')
          end

          it 'should have name that matches' do
            expect(school.name).to eql('Qualquer Unidade da USP')
          end

          it 'should have data that matches' do
            expect(school.vacancies).to eql(0)
            expect(school.inscribed).to eql(0)
            expect(school.pending).to eql(0)
            expect(school.enrolled).to eql(0)
          end
        end # third entry

        context 'fourth entry' do
          let(:school) { schools[3] }

          it 'should have kind that matches' do
            expect(school.kind).to eql('Optativa Livre')
          end

          it 'should have name that matches' do
            expect(school.name).to eql('FSP - Nutrição (Diurno e Noturno)')
          end

          it 'should have data that matches' do
            expect(school.vacancies).to eql(5)
            expect(school.inscribed).to eql(1)
            expect(school.pending).to eql(0)
            expect(school.enrolled).to eql(1)
          end
        end # fourth entry

      end # schools
    end # its second classroom

  end # when parsing page
end # Parser
