# ruby encoding: utf-8

def parse_classroom(table)
  rows = table.search('tr')
  raise 'wrong table!' unless rows.first.text.include? 'Código'

  code = rows[0].search('td')[1].text.strip
  date_begin = rows[1].search('td')[1].text.strip
  date_end = rows[2].search('td')[1].text.strip
  kind = rows[3].search('td')[1].text.strip

  # algumas materias nao contem observacoes
  notes = rows[4].search('td')[1].text.strip unless rows[4].nil?

  puts " - code: #{code}",
  " - begin: #{date_begin}",
  " - end: #{date_end}",
  " - kind: #{kind}",
  " - notes: #{notes}"
end

def parse_schedule(table)
  rows = table.search('tr')
  raise 'wrong table!' unless rows.first.text.include? 'Horário'

  # descarta cabecalho da tabela
  rows.shift

  i = 0
  while i < rows.count
    tds = rows[i].search('td').map { |td| td.text.strip }

    week_day = tds[0]
    time_begin = tds[1]
    time_end = tds[2]
    teachers = [].push(tds[3])

    # procura outros professores nas linhas abaixo
    # ex: seg 14:00 16:00 ProfA
    #                     ProfB
    # resultado: teachers = ['ProfA', 'ProfB']
    last_index = i
    (i+1..rows.length-1).each do |j|
      tds = rows[j].search('td').map { |td| td.text.strip }

      # se linha contem dia da semana
      # eh outra agenda
      # sai para o laço externo e começa outra agenda
      break if tds[0].length > 1

      # adiciona o professor ao array
      teachers.push(tds[3])

      # guarda o indice j para usar no laço externo
      last_index = j
    end

    # retoma da ultima linha visitada em busca de professores
    # evitando duas visitas a mesma linha
    i = last_index + 1

    # remove duplicatas
    teachers.uniq!

    puts " - week: #{week_day}",
    " - begin: #{time_begin}",
    " - end: #{time_end}",
    " - teachers: #{teachers}"
  end
end

def parse_campus(table)
  rows = table.search('tr')
  raise 'wrong table!' unless rows.first.text.include? 'Vagas'

  # descarta cabecalho da tabela
  rows.shift

  i = 0
  while i < rows.count
    tds = rows[i].search('td').map { |td| td.text.strip }
    data = tds.from(1).map { |td| td.to_i }
    kind = tds[0]

    # flag para checar se existe campus nas linhas abaixo
    has_more_lines = false

    # procura por campus nas linhas abaixo
    # ex: Obrigatoria             66 60  1 59
    #         EACH - SI - Diurno  66 42  1 41
    last_index = i
    (i+1..rows.length-1).each do |j|
      has_more_lines = true
      tds = rows[j].search('td').map { |td| td.text.strip }

      # se a linha contem Obrigatoria ou Optativa
      # eh um novo campus
      # sai para o laço externo e comeca outro campus
      break if tds[0].include? 'Obrigatória' && 'Optativa'

      data = tds.from(2).map { |td| td.to_i }

      name = tds[1]
      vacancies = data[0]
      inscribed = data[1]
      pending = data[2]
      enrolled = data[3]

      # guarda o indice j para usar no laço externo
      last_index = j

      puts " - name: #{name}",
    " - kind: #{kind}",
    " - vacancies: #{vacancies}",
    " - inscribed: #{inscribed}",
    " - pending: #{pending}",
    " - enrolled: #{enrolled}",
    " ------------------------------ "
    end

    # se nao teve nenhuma linha abaixo com descricao do campus
    # adiciona novo campus sem nome, mas com os dados
    unless has_more_lines
      name = ''
      vacancies = data[0]
      inscribed = data[1]
      pending = data[2]
      enrolled = data[3]

      puts " - name: #{name}",
    " - kind: #{kind}",
    " - vacancies: #{vacancies}",
    " - inscribed: #{inscribed}",
    " - pending: #{pending}",
    " - enrolled: #{enrolled}",
    " ------------------------------ "
    end

    # retoma da ultima linha visitada em busca de campus
    # evitando duas visitas a mesma linha
    i = last_index + 1
  end
end

def parse_subject(page, code, name)
  puts "parsing subject #{code} #{name}"
  tables = page.at('td[width="568"]').search('table')
  raise 'wrong page!' if tables.count % 3 != 0

end
