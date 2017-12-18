require 'nokogiri'
require 'pry'


xsd = Nokogiri::XML::Schema(File.read('./persons.xsd'))
doc = Nokogiri::XML(File.read('./persons.xml'))

valid = true

xsd.validate(doc).each do |error|
  puts error.message
  valid = false
end

if valid
  p 'Doc is valid'
else
  p 'Doc is invalid'
end