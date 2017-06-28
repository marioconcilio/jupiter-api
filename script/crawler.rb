#!/usr/bin/env ruby
# ruby encoding: utf-8

require 'nokogiri'
require 'open-uri'

module Crawler
  TEMP_PATH = 'script/temp'

  URL_UNIDADES = 'https://uspdigital.usp.br/jupiterweb/jupColegiadoLista?tipo=D'
  URL_MATERIAS = 'https://uspdigital.usp.br/jupiterweb/jupDisciplinaLista?letra=A-Z&tipo=D&codcg='
  URL_TURMAS = 'https://uspdigital.usp.br/jupiterweb/obterTurma?print=true&sgldis='

  def download_pages
    puts 'Obtendo a lista de todas as unidades de ensino'

    # deleta diretorio temporario e cria novo
    FileUtils.rm_rf(TEMP_PATH)
    Dir.mkdir(TEMP_PATH)

    # pagina contendo todas as unidades da USP
    page = Nokogiri::HTML(open(URL_UNIDADES, read_timeout: 20))

    # procura por todos os links contendo 'jupColegiadoMenu'
    link_unidades = page.css('a[@href*="jupColegiadoMenu"]')

    # extrai o codigo da materia embutido no link
    # ex: jupColegiadoMenu.jsp?codcg=86&tipo=D&nomclg=Escola+de+Artes,+Ciências+e+Humanidades
    # código = 86
    codigo_unidades = Parallel.map(link_unidades) do |link|
      link['href'].match(/codcg=(\d+)/)[1]
    end

    puts "#{codigo_unidades.count} unidades encontradas"

    Parallel.each(codigo_unidades, progress: 'Downloading') do |unidade|
      # pagina contendo todas as materias da unidade
      page = Nokogiri::HTML(open("#{URL_MATERIAS}#{unidade}", read_timeout: 20))

      # procura por todos os links contento 'obterDisciplina'
      link_materias = page.css('a[@href*="obterDisciplina"]')

      # extrai o codigo da materia contido no link e o nome
      # ex: obterDisciplina?sgldis=ACH2016&verdis=2
      # codigo = ACH2016
      materias_unidade = Parallel.map(link_materias) do |link|
        link['href'].match(/sgldis=([A-Z0-9]+)/)[1]
      end
      next if materias_unidade.count == 0

      # cria diretorio com o codigo da unidade
      Dir.mkdir("#{TEMP_PATH}/#{unidade}")

      Parallel.each(materias_unidade) do |codigo|
        next if codigo.length != 7

        # pagina contendo oferecimento da materia
        page = Nokogiri::HTML(open("#{URL_TURMAS}#{codigo}", read_timeout: 20))

        # verifica se existe oferecimento
        unless page.css('div#web_mensagem').text.include? "Não existe oferecimento"
          # escreve pagina html no disco
          File.write("#{TEMP_PATH}/#{unidade}/#{codigo}.html", page)
        end

      end # materias_unidade.each
    end # codigo_unidades.each

  end # def download_pages
end
