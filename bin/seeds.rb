# ruby encoding: utf-8

def parse_classroom(table)
  rows = table.search('tr')

  code = rows[0].search('td')[1].text.strip
  date_begin = rows[1].search('td')[1].text.strip
  date_end = rows[2].search('td')[1].text.strip
  kind = rows[3].search('td')[1].text.strip
  notes = rows[4].search('td')[1].text.strip
end

def parse_schedule(table)
  rows = table.search('tr')

  rows.from(1).each do |index, row|
    week_day = row.search('td')[0].text.strip
    time_begin = row.search('td')[1].text.strip
    time_end = row.search('td')[2].text.strip
    teachers = [row.search('td')[3].text.strip]
  end
end

def parse_subject(page, code, name)
  puts "parsing subject #{code} #{name}"

  # table = page.at('form[@name="form1"]')

  tables = page.at('td[width="568"]')
  tables.search('table')
end
