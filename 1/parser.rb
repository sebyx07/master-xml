require 'nokogiri'
require 'pry'
require 'ostruct'
require 'saxerator'

class User < OpenStruct
end

parser = Saxerator.parser(File.new('persons.xml'))

doc = File.open('persons.xml') do |f|
  Nokogiri::Slop(f)
end

persons = doc.css('person').map do |node|
  attr_list = [:name, :age]
  attrs = {}
  attr_list.each do |attr|
    attrs[attr] = node.css(attr).text
  end

  User.new(attrs)
end

p 'DOM PARSER'
p persons

persons_sax = []

parser.for_tag(:person).each do |person|
  persons_sax << User.new(name: person['name'], age: person['age'])
end

p 'SAX PARSER'
p persons_sax


