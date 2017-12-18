require 'nokogiri'
require 'pry'
require 'ostruct'


xsd = Nokogiri::XML::Schema(File.read('./school.xsd'))
doc = Nokogiri::XML(File.read('./school.xml'))

valid = true

xsd.validate(doc).each do |error|
  puts error.message
  valid = false
end

unless valid
  return p 'Doc is invalid'
end

class User < OpenStruct; end
class Book < OpenStruct; end

persons =  doc.css('person').map do |node|
  attr_list = [:name, :age]
  attrs = {}
  attr_list.each do |attr|
    attrs[attr] = node.css(attr).text
  end
  User.new(attrs)
end

books =  doc.css('book').map do |node|
  attr_list = [:name, :'number-of-pages']
  attrs = {}
  attr_list.each do |attr|
    attrs[attr] = node.css(attr).text
  end

  Book.new(attrs)
end

p "persons: #{persons}"
p "books: #{books}"