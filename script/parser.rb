# ruby encoding: utf-8

module Parser
  ParsedPage = Struct.new(:subject, :classrooms, :schedules, :schools)

  def parse_classroom(table, subject=nil)
    rows = table.search('tr')
    while not rows.first.text.include? 'Código'
      rows.shift
      return nil if rows.first.nil?
    end
    return nil if rows.empty?

    code = rows[0].search('td')[1].text.strip
    date_begin = rows[1].search('td')[1].text.strip
    date_end = rows[2].search('td')[1].text.strip
    kind = rows[3].search('td')[1].text.strip

    # algumas materias nao contem observacoes
    notes = rows[4].search('td')[1].text.strip unless rows[4].nil?

    classroom = Classroom.new(
      code: code,
      date_begin: date_begin,
      date_end: date_end,
      kind: kind,
      notes: notes,
      subject: subject)

    classroom.save
    return classroom
  end # parse_classroom

  def parse_schedules(table, classroom=nil)
    rows = table.search('tr')
    return nil unless rows.first.text.include? 'Horário'

    # descarta cabecalho da tabela
    rows.shift

    schedules = []

    i = 0
    while i < rows.count
      tds = rows[i].search('td').map { |td| td.text.strip }

      week_day = tds[0]
      time_begin = Time.zone.parse(tds[1]).utc
      time_end = Time.zone.parse(tds[2]).utc
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
      end # (i+1..rows.length-1).each

      # retoma da ultima linha visitada em busca de professores
      # evitando duas visitas a mesma linha
      i = last_index + 1

      # remove duplicatas
      teachers.uniq!

      s = Schedule.new(
        week_day: week_day,
        time_begin: time_begin,
        time_end: time_end,
        teachers: teachers,
        classroom: classroom)

      s.save
      schedules.push(s)
    end # while i < rows.count

    return schedules
  end #parse_schedule

  def parse_schools(table, classroom=nil)
    rows = table.search('tr')
    raise 'wrong table!' unless rows.first.text.include? 'Vagas'

    # descarta cabecalho da tabela
    rows.shift

    schools = []

    i = 0
    while i < rows.count
      tds = rows[i].search('td').map { |td| td.text.strip }
      data = tds.from(1).map { |td| td.to_i }
      kind = tds[0]

      # flag para checar se existe escolas nas linhas abaixo
      has_more_lines = false

      # procura por escolas nas linhas abaixo
      # ex: Obrigatoria             66 60  1 59
      #         EACH - SI - Diurno  66 42  1 41
      last_index = i
      (i+1..rows.length-1).each do |j|
        #tds = rows[j].search('td').map { |td| td.text.strip }
        tds = rows[j].search('td')

        # se a linha contem Obrigatoria ou Optativa
        # eh uma nova escola
        # sai para o laço externo e comeca outra escola
        # break if tds[0].include? 'Obrigatória' && 'Optativa'
        break if tds.at('span').attributes['class'].value == 'txt_arial_8pt_black'
        has_more_lines = true

        tds = tds.map { |td| td.text.strip }
        data = tds.from(2).map { |td| td.to_i }

        # guarda o indice j para usar no laço externo
        last_index = j

        s = School.new(
          name: tds[1],
          kind: kind,
          vacancies: data[0],
          inscribed: data[1],
          pending: data[2],
          enrolled: data[3],
          classroom: classroom)

        s.save
        schools.push(s)
      end # while i < rows.count

      # se nao teve nenhuma linha abaixo com descricao da escola
      # adiciona nova escola sem nome, mas com os dados
      unless has_more_lines
        s = School.new(
          name: '',
          kind: kind,
          vacancies: data[0],
          inscribed: data[1],
          pending: data[2],
          enrolled: data[3])

        s.save
        schools.push(s)
      end # unless has_more_lines

      # retoma da ultima linha visitada em busca de escola
      # evitando duas visitas a mesma linha
      i = last_index + 1
    end # while i < rows.count

    return schools
  end # parse_school

  def parse_subject(code, name)
    raise 'wrong code!' if code.nil? || code.empty?
    raise 'wrong name!' if name.nil? || name.empty?

    subject = Subject.new(
      code: code,
      name: name)

    subject.save
    return subject
  end # parse_subject

  def parse_page(path)
    page = Nokogiri::HTML(File.read(path, encoding: 'utf-8'))
    tables = page.at('td[width="568"]').search('table')
    # raise 'wrong page!' unless tables.count % 3 == 0
    return nil unless tables.count % 3 == 0

    # procura pelos titulos da pagina
    # o ultimo contem o nome e o codigo da materia
    # divide a string no caractere '-''
    # ex: Disciplina ABC0123 - Testecultura
    title = page.search('span[class="txt_arial_10pt_black"]').last.text.strip.split(' - ')

    # codigo da materia sao os ultimos 7 caracteres do primeiro elemento da lista
    # ex: Disciplina ABC0123
    code = title.first.last(7)

    # nome da materia eh ultimo elemento da lista
    # ex: Testecultura
    name = title.last
    subject = parse_subject(code, name)

    classrooms = []
    schedules = []
    schools = []

    i = 0
    while i < tables.count
      classroom = parse_classroom(tables[i], subject)
      schedules.push(parse_schedules(tables[i+1], classroom))
      schools.push(parse_schools(tables[i+2], classroom))
      classrooms.push(classroom)

      i += 3
    end # while

    return ParsedPage.new(subject, classrooms, schedules, schools)
  end # parse_page
end
