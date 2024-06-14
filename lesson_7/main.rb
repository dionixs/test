# frozen_string_literal: true

require_relative './lib/validatable'
require_relative './lib/instance_counter'
require_relative './lib/vendor'
require_relative './lib/station'
require_relative './lib/route'
require_relative './lib/train'
require_relative './lib/wagon'
require_relative './lib/cargo_train'
require_relative './lib/passenger_train'
require_relative './lib/cargo_wagon'
require_relative './lib/passenger_wagon'
require_relative './seed/seed'

attempt = 0

routes = []

def create_station
  puts 'Введите название станции:'
  print '> '
  name = gets.strip.capitalize

  station = Station.find(name)

  if station
    puts 'Станция уже существует!'
    station
  else
    puts 'Станция успешно создана!'
    Station.new(name)
  end
end

def create_train
  puts 'Введите тип поезда:'
  puts ' 1 - Пассажирский поезд'
  puts ' 2 - Грузовой поезд'
  print '> '
  type = gets.to_i

  puts 'Введите номер поезда:'
  print '> '
  number = gets.strip

  if Train.find(number)
    puts 'Поезд уже существует!'
  elsif type == 1
    train = PassengerTrain.new(number)
    puts 'Поезд успешно создан!'
    train
  elsif type == 2
    train = CargoTrain.new(number)
    puts 'Грузовой поезд успешно создан!'
    train
  else
    puts 'Тип поезда неверен!'
  end
end

def create_route(routes)
  puts 'Введите имя начальной станции или выберете ее из списка ниже:'
  show_stations
  print '> '
  start_station = gets.strip

  if start_station.to_i.zero?
    Station.new(start_station)
  else
    start_station = start_station.to_i - 1
  end

  puts 'Введите имя конечной станции или выберете ее из списка ниже:'
  show_stations
  print '> '
  end_station = gets.strip

  if end_station.to_i.zero?
    Station.new(end_station)
  else
    end_station = start_station.to_i - 1
  end

  if start_station == end_station
    puts 'Начальная и конечная станции совпадают!'
  else
    stations = Station.all
    start_station = stations[start_station] if start_station.is_a?(Integer)
    end_station = stations[end_station] if end_station.is_a?(Integer)
    route = Route.new(start_station, end_station)
    routes << route
  end

  station_control(routes, route)
end

def choice_route(routes)
  routes.each_with_index do |route, index|
    print " #{index + 1}: "
    route.all_stations
    puts
  end
  print '> '
  route = gets.to_i
  routes[route - 1]
end

def choice_train
  Train.all.each_with_index do |train, index|
    type = train.type == Train::PASSENGER_TYPE ? 'пассажирский' : 'грузовой'
    puts "\t#{index + 1}. #{train.number}, тип поезда: #{type}"
  end
  print '> '
  train = gets.to_i
  Train.all[train - 1]
end

def station_control(routes, route = nil)
  puts 'Выберете маршрут для изменения:'
  route = choice_route(routes) if route.nil?

  puts 'Выберете действие:'
  puts ' 1 - Добавить промеж. станцию'
  puts ' 2 - Удалить промеж. станцию'
  print '> '
  action = gets.to_i

  case action
  when 1
    station = create_station
    routes.delete(route)
    route.add_station(station)
    routes << route
    puts 'Станция успешно добавлена в маршрут!'
  when 2
    puts 'Выберете какую станцию вы хотите удалить:'
    route.stations.each_with_index do |s, index|
      puts "#{index + 1} - #{s.name}"
    end
    print '> '
    station = gets.to_i
    station = route.stations[station - 1]
    puts route.remove_station(station)
  else
    puts 'Ошибка в выборе действия!'
  end
end

def add_route_to_train(routes)
  puts 'Выберете поезд:'
  train = choice_train

  puts 'Выберете маршрут для поезда:'
  route = choice_route(routes) if route.nil?

  train.add_route(route)

  puts 'Маршрут для поезда назначен!'
end

def add_wagons_to_train(train = nil)
  if train.nil?
    puts 'Выберете поезд:'
    train = choice_train
  end

  puts 'Введите кол-во вагонов которое вы хотите добавить:'
  print '> '
  wagon_count = gets.to_i

  if train.type == Wagon::PASSENGER_TYPE
    puts 'Укажите кол-во мест в вагоне:'
    print '> '
    total_seats = gets.to_i
  else
    puts 'Укажите общий объем вагона:'
    print '> '
    total_volume = gets.to_i
  end

  wagon_count.times do
    wagon = if train.type == Train::PASSENGER_TYPE
              PassengerWagon.new { |p| p.total_seats = total_seats }
            else
              CargoWagon.new { |p| p.total_volume = total_volume }
            end
    train.add_wagon(wagon)
  end
  puts 'Вагоны добавлены!'
end

def remove_wagons_to_train
  puts 'Выберете поезд:'
  train = choice_train

  puts 'Введите кол-во вагонов которое вы хотите добавить:'
  wagon_count = gets.to_i

  wagon_count.times do
    wagon = train.type == Train::PASSENGER_TYPE ? PassengerWagon.new : CargoWagon.new
    puts train.remove_wagon(wagon)
  end
  puts 'Вагоны отцеплены!'
end

def move_train
  puts 'Выберете поезд для перемещения:'
  train = choice_train

  puts "Текущая станция: #{train.current_station}"

  puts 'Выберете куда переместить поезд:'
  puts ' 1 - Вперед'
  puts ' 2 - Назад'
  print '> '
  input = gets.to_i

  if input == 1
    train.forward
  elsif input == 2
    train.backward
  else
    puts 'Ошибка в выборе действия!'
  end

  if train.wagons.empty?
    puts 'У поезда нет вагонов! Необходимо добавить вагоны к поезду!'
    add_wagons_to_train(train)
  end

  if train.type == Train::PASSENGER_TYPE
    train.wagons.each do |wagon|
      rand(0..wagon.total_seats).times do
        wagon.take_seat
      end
    end
    puts 'Произошла посадка пассажиров в поезд'
  else
    train.wagons.each do |wagon|
      volume = rand(0..wagon.total_volume)
      wagon.take_volume(volume)
    end
    puts 'Произошла погрузка в поезд'
  end

  puts "Поезд перемещен на станцию: #{train.current_station}"
end

def show_stations
  puts 'Список станций:'
  Station.all.each_with_index do |station, index|
    puts " #{index + 1} - #{station.name}"
  end
end

def show_trains
  puts 'Показать список поездов для всех станций или для определенной? (Y/n)'
  print '> '
  input = gets.chomp.downcase

  if input == 'y'
    Station.all.each do |station|
      puts "Список поездов на станции: #{station.name}"

      if station.trains.empty?
        puts "\tПоездов на станции нет!"
      else
        display_trains_for_station(station)
      end
    end
  else
    puts 'Выберете станцию из списка :'
    show_stations
    print '> '
    station = gets.to_i
    station = Station.all[station - 1]

    puts "Список поездов на станции: #{station.name}"
    display_trains_for_station(station)
  end
end

def display_trains_for_station(station)
  station.each_train_with_index do |train, index|
    type = train.type == Train::PASSENGER_TYPE ? 'пассажирский' : 'грузовой'
    index += 1
    wagons = train.wagons.size
    puts "\t#{index}. номер поезда:  #{train.number}, тип поезда: #{type}, кол-во вагонов: #{wagons}"
  end
end

def show_wagons
  puts 'Выберете поезд для просмотра списка вагонов:'
  train = choice_train

  puts "Список вагонов у поезда #{train.number}"

  train.each_wagon_with_index do |wagon, index|
    type = wagon.type == Train::PASSENGER_TYPE ? 'пассажирский' : 'грузовой'
    index += 1
    puts "\t#{index}. номер вагона: #{wagon.number} , тип вагона: #{type}"
    if wagon.type == Train::PASSENGER_TYPE
      puts "\t\tкол-во свободных мест: #{wagon.free_seats}, занятых мест: #{wagon.busy_seats}"
    else
      puts "\t\tкол-во свободного объема: #{wagon.free_volume}, занятого объема: #{wagon.busy_volume}"
    end
  end
end

def commands
  puts 'Команды:'
  puts ' 1 - Создать станцию'
  puts ' 2 - Создать поезд'
  puts ' 3 - Создать маршрут'
  puts ' 4 - Управление станциями в маршруте'
  puts ' 5 - Назначить маршрут поезду'
  puts ' 6 - Добавить вагоны к поезду'
  puts ' 7 - Отцепить вагоны от поезда'
  puts ' 8 - Переместить поезд по маршруту'
  puts ' 9 - Просмотреть список станций'
  puts ' 10 - Просмотреть список поездов на станции'
  puts ' 11 - Просмотреть список вагонов у поезда'
  puts ' help - Список команд'
  puts ' exit - Выход'
end

puts 'Добро пожаловать в систему управления железнодорожными станциями!'
puts 'Введите help чтобы посмотреть список команд'

begin
  loop do
    print '> '
    input = gets&.strip&.downcase

    begin
      case input
      when 'exit'
        break
      when 'help'
        commands
      when '1'
        create_station
      when '2'
        create_train
      when '3'
        create_route(routes)
      when '4'
        station_control(routes)
      when '5'
        add_route_to_train(routes)
      when '6'
        add_wagons_to_train
      when '7'
        remove_wagons_to_train
      when '8'
        move_train
      when '9'
        show_stations
      when '10'
        show_trains
      when '11'
        show_wagons
      else
        puts "Команда #{input} не найдена!"
      end
    rescue StandardError => e
      attempt += 1
      puts "Возникла ошибка: #{e.message}. Попробуйте еще раз!"
      puts "Попыток: #{attempt}" if attempt.positive?
      retry if attempt < 3
      puts 'Достигнуто максимальное кол-во попыток. Попробуйте позже.'
      attempt = 0
      next
    end
  end
rescue Interrupt
  # Ignored
end
