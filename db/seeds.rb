# ruby encoding: utf-8
#
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'

def create_schedule(array, classroom)
  begin
    time_end = Time.parse(array[2])
  rescue ArgumentError
    time_end = nil
  end

  schedule = Schedule.create(
    week_day: array[0],
    time_begin: Time.parse(array[1]),
    time_end: time_end,
    teachers: array[3],
    classroom: classroom)
end

def create_classroom(array, subject)
  classroom = Classroom.create(
    code: array[0],
    date_begin: Date.strptime(array[1], "%d/%m/%Y"),
    date_end: Date.strptime(array[2], "%d/%m/%Y"),
    kind: array[3],
    subject: subject)

  unless array[4].nil?
    array[4].each do |s|
      create_schedule(s, classroom)
    end
  end
end

def create_subject(array)
  subject = Subject.create(
    code: array[0],
    name: array[1])

  array[2].each do |c|
    create_classroom(c, subject)
  end
end

Time.zone = "America/Sao_Paulo"
json = JSON.parse(File.read("db/jupiterweb.json"))["TODOS"]
json.each do |s|
  create_subject(s)
end
