require 'rexml/document'

# XXX/ Этот код необходим только при использовании русских букв на Windows
if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end
# /XXX
#
xml_path = File.dirname(__FILE__) + "/data/business_card.xml"
html_path = File.dirname(__FILE__) + "/data/business_card.html"

abort "Хмл файл не найден" unless File.exist?(xml_path)

file = File.new(xml_path, "r:UTF-8")
xml_file = REXML::Document.new(file)
file.close

xml_structure = {}

["first_name", "second_name", "last_name", "phone", "email", "skills", "photo"].each do |field|
  xml_structure[field] = xml_file.root.elements[field].text
end

html_structure = REXML::Document.new
html_structure.add_element("html", {"lang" => "ru"})
html_structure.root.add_element("head").add_element("meta", {"charset" => "UTF-8"})
body = html_structure.root.add_element("body")
body.add_element('p').add_element('img', 'src' => xml_structure['photo'])

body.add_element('h1').add_text(
  "#{xml_structure['first_name']} #{xml_structure['second_name'][0]}. #{xml_structure['last_name']}"
)

body.add_element('p').add_text(xml_structure['skills'])
body.add_element('p').add_text("Телефон: #{xml_structure['phone']}")
body.add_element('p').add_text("Email: #{xml_structure['email']}")

# Открываем его для записи
file = File.new(html_path, 'w:UTF-8')

# Эта строка нужна, чтобы браузер понял, что это за HTML-документ
file.puts('<!DOCTYPE HTML>')

# Наконец, запишем нашу html-структуру в файл и закроем его
html_structure.write(file, 2)
file.close