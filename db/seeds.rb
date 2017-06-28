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

download_pages

folders = Dir.glob("#{Crawler::TEMP_PATH}/*")
pages = folders.flat_map { |f| Dir.glob("#{f}/*.html") }

Parallel.each(pages, progress: 'Saving', in_threads: 8) do |p|
  ActiveRecord::Base.connection_pool.with_connection do
    ActiveRecord::Base.transaction do
      parse_page(p)
    end
  end
end
