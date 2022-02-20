# frozen_string_literal: true

require_relative 'test_main'

puts 'Введите paid_till в формате дд.мм.гггг или дд.мм.гг:'
paidtill = gets.chomp
puts 'Введите значение max_version:'
maxversion = gets.chomp
puts 'Введите значение min_version:'
minversion = gets.chomp
license = License.new(paidtill, maxversion, minversion)
puts 'Введите последнюю версию Flussonic:'
var = gets.chomp
print license.get_versions(var)
