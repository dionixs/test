products = {}

product_name = nil

until product_name == 'стоп'
  puts 'Введите название товара:'
  product_name = gets.strip

  next if product_name == 'стоп'

  puts 'Введите цену за единицу товара:'
  price = gets.to_i

  puts 'Введите кол-во купленного товара:'
  quantity = gets.to_f

  item_total_price = price * quantity
  products[product_name] = { price:, quantity:, item_total_price: }
end

total_price = 0

products.each do |name, value|
  puts '=' * 50
  puts "Название товара: #{name}"
  puts "Цена за единицу товара: #{value[:price]}"
  puts "Кол-во купленного товара: #{value[:quantity]}"
  puts "Итоговая сумма за каждый товар: #{value[:item_total_price]}"
  total_price += value[:item_total_price]
end

puts '=' * 50
puts "Итоговая сумма всех покупок: #{total_price}"
