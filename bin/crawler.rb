#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'

URL_UNIDADES = 'https://uspdigital.usp.br/jupiterweb/jupColegiadoLista?tipo=D'
URL_MATERIAS = 'https://uspdigital.usp.br/jupiterweb/jupDisciplinaLista?letra=A-Z&tipo=D&codcg='

puts 'Obtendo a lista de todas as unidades de ensino'
page = Nokogiri::HTML(open(URL_UNIDADES))

# procura por todos os links contendo 'jupColegiadoMenu'
link_unidades = page.css('a[@href*="jupColegiadoMenu"]')

# extrai o codigo da materia embutido no link
# ex: jupColegiadoMenu.jsp?codcg=86&tipo=D&nomclg=Escola+de+Artes,+Ciências+e+Humanidades
# código = 86
codigo_unidades = link_unidades.map do |link|
  link['href'].match(/codcg=(\d+)/)[1]
end

puts "#{codigo_unidades.count} unidades encontradas"

materias = {}
codigo_unidades.each do |codigo|
  puts "Obtendo matérias da unidade #{codigo}"
  page = Nokogiri::HTML(open(URL_MATERIAS + codigo))

  # procura por todos os links contento 'obterDisciplina'
  link_materias = page.css('a[@href*="obterDisciplina"]')

  # extrai o codigo da materia contido no link e o nome
  # ex: obterDisciplina?sgldis=ACH2016&verdis=2
  # codigo = ACH2016
  materias_unidade = link_materias.map do |link|
    [link['href'].match(/sgldis=([A-Z0-9]+)/)[1], link.text]
  end

  puts "#{materias_unidade.count} materias encontradas"

  # dicionario com todas as materias da unidade
  materias[codigo] = materias_unidade
end

materias.each do |unidade, materias|
  puts "Processando materias da unidade #{unidade}"

  materias.each do |codigo, nome|

  end
end
