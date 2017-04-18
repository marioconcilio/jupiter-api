# ruby encoding: utf-8
#
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require_relative '../script/crawler'
require_relative '../script/parser'

include Crawler, Parser

# get all subjects pages and parse them into ActiveRecord models
pages = get_pages.map { |p| parse_page(page: p.page, code: p.code, name: p.name) }

# save all models to database
pages.each do |p|
  p.subject.save
  p.classrooms.map { |c| c.save }
  p.schedules.flatten.map { |c| c.save }
  p.schools.flatten.map { |c| c.save }
end
