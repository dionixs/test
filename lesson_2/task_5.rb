def year_leap?(year)
  ((year % 4).zero? && year % 100 != 0) || (year % 400).zero?
end

months = {
  1 => 31,
  2 => [28, 29],
  3 => 31,
  4 => 30,
  5 => 31,
  6 => 30,
  7 => 31,
  8 => 31,
  9 => 30,
  10 => 31,
  11 => 30,
  12 => 31
}

puts 'Введите день:'
day = gets.to_i

puts 'Введите месяц:'
month = gets.to_i

puts 'Введите год:'
year = gets.to_i

days_in_year = year_leap?(year) ? 366 : 365

months[month] = day

current_day_number = 0

month.times do |index|
  index += 1
  if index == 2 && days_in_year == 365
    return current_day_number += months[index][0]
  elsif index == 2 && days_in_year == 366
    current_day_number += months[index][1]
  else
    current_day_number += months[index]
  end
end

puts "Номер дня в году: #{current_day_number}"
