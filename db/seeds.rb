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

json = JSON.parse(File.read("db/jupiterweb.json"))["TODOS"]
print json.to_json

def create_schedule(dict, classroom)
  schedule = Schedule.create(
    week_day: dict[0],
    time_begin: Time.parse(dict[1]),
    time_end: Time.parse(dict[2]),
    teachers: dict[3],
    classroom: classroom)
end

def create_classroom(dict)
end
