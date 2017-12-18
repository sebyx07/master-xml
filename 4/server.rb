require 'cuba'
require 'nokogiri'
require 'json'
require 'pry'

Cuba.define do
  on get do
    on ':filename/:type/:name' do |filename, type, name|
      file = "#{filename}.xml"
      unless File.exists?(file)
        return res.write('File Not Found')
      end
      doc = Nokogiri::XML(File.read('./school.xml'))
      list = doc.css("#{type}")
      el = list.find do |node|
        node.css('name').text == name
      end
      res['Content-Type'] = 'application/xml'
      res.write el
    end
  end
end