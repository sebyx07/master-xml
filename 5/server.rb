require 'cuba'
require 'nokogiri'
require 'json'
require 'pry'
require 'erb'

DOC =  Nokogiri::XML(File.read('./school.xml'))

def get_xslt(file)
  xslt = Nokogiri::XSLT(File.read("./views/#{file}.xslt"))
  xslt.transform(DOC)
end

def get_xslt_erb(file, index)
  file = File.read("./views/#{file}.xslt.erb")
  erb = ERB.new(file).result(binding)
  xslt = Nokogiri::XSLT(erb)
  xslt.transform(DOC)
end

Cuba.define do
  on get do
    on 'persons/:index' do |index|
      view = 'person'
      res.write get_xslt_erb(view, index)
    end

    on 'books/:index' do |index|
      view = 'book'
      res.write get_xslt_erb(view, index)
    end

    on 'persons' do
      view = 'persons'
      res.write get_xslt(view)
    end

    on 'books' do
      view = 'books'
      res.write get_xslt(view)
    end

    # on ':filename/:type/:name' do |filename, type, name|
    #   file = "#{filename}.xml"
    #   unless File.exists?(file)
    #     return res.write('File Not Found')
    #   end
    #   # list = doc.css("#{type}")
    #   # el = list.find do |node|
    #   #   node.css('name').text == name
    #   # end
    #   # res['Content-Type'] = 'application/xml'
    #   # res.write el
    # end
    #
    # on ':filename/:type/' do |filename, type|
    #   file = "#{filename}.xml"
    #   unless File.exists?(file)
    #     return res.write('File Not Found')
    #   end
    #   doc = Nokogiri::XML(File.read('./school.xml'))
    #   if type == 'persons'
    #     xslt = Nokogiri::XSLT(File.read('./views/persons.xslt'))
    #   end
    #
    #   res.write()
    # end
  end
end