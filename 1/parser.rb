require 'nokogiri'
require 'pry'
require 'ostruct'

class User < OpenStruct
end


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

p persons

