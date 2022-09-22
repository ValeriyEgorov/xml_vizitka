# Сделайте свою визитку в формате XML.
#
#   Укажите свои фамилию, имя, отчество, телефон, адрес электронной почты и немного напишите о своих навыках.
#
#   Напишите программу, которая читает эту визитку в формате XML и красиво выводит информацию на экран.
#
#   Например:
#
#   Иван А. Попов
# +7 999 100-30-20, ivan.popov@mail.ru
# Начинающий программист на Ruby

#Подключим парсер ХМЛ
require 'rexml/document'

#Пропишем путь к файлу
current_path = File.dirname(__FILE__)
puts current_path
file_path = current_path + "./business_card.xml"

#Проверим наличие файла
unless File.exist?(file_path)
  abort "Хмл файл с данными не найден"
end

#Распарсим хмл файл в объект
file = File.new(file_path, "r:UTF-8")
doc = REXML::Document.new(file)
file.close

#Выведем информацию
puts "#{doc.elements['business_card/first_name'].text} #{doc.elements['business_card/second_name'].text[0]}. "\
       "#{doc.elements['business_card/last_name'].text}"
puts "#{doc.elements['business_card/phone'].text}, #{doc.elements['business_card/email'].text}"
puts "#{doc.elements['business_card/skills'].text}"