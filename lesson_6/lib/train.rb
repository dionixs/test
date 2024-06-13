# frozen_string_literal: true

class Train
  include InstanceCounter
  include Validatable
  include Vendor

  @@trains ||= []

  def self.all
    @@trains
  end

  def self.find(number)
    @@trains.find { |t| t.number == number }
  end

  PASSENGER_TYPE = :passenger
  CARGO_TYPE = :cargo

  INITIAL_SPEED = 0
  PASSENGER_SPEED = 50

  INITIAL_STATION = 0

  # три буквы или цифры в любом порядке
  # необязательный дефис (может быть, а может нет)
  # и еще 2 буквы или цифры после дефиса
  NUMBER_FORMAT = /^[a-zа-я0-9]{3}-?[a-zа-я0-9]{2}$/i

  attr_reader :number, :type, :speed, :stations

  def initialize(number)
    @number = number
    @wagons = []
    @stations = []
    @speed = INITIAL_SPEED
    @station = INITIAL_STATION
    validate! if instance_of?(Train)
    @@trains << self if valid?
    register_instance if valid?
  end

  def go
    @speed = PASSENGER_SPEED
  end

  def stop
    @speed = INITIAL_SPEED
  end

  def add_wagon(wagon)
    @wagons << wagon if can_attach?(wagon)
  end

  def remove_wagon(wagon)
    @wagons.delete(wagon) if can_detach?(wagon)
  end

  def add_route(route)
    @stations = route.stations
  end

  def current_station
    @stations[@station].name
  end

  def show_forward_station
    return start_station_name if start_station?

    forward_station_name
  end

  def show_backward_station
    return end_station_name if end_station?

    backward_station_name
  end

  def forward
    return if @station == @stations.size - 1

    @station += 1
    @stations[@station]
  end

  def backward
    return @stations[@station] if @station.zero?

    @station -= 1
    @stations[@station]
  end

  def valid?
    validate!
    true
  rescue NotImplementedError
    false
  rescue StandardError
    false
  end

  protected

  def validate!
    raise NotImplementedError, 'Unable to create an object of a Class that is a parent!' if instance_of?(Train)
    raise 'Number of train cannot be blank' if number.nil?
    raise 'Number of train must be between 5 and 6 characters long' if invalid_length?(number, 5, 6)
    raise 'Number has invalid format' if number !~ NUMBER_FORMAT
    raise 'Vendor name must be between 2 and 50 characters long' if !vendor_name.nil? && invalid_length?(vendor_name)
  end

  private

  # метод который проверяет можно ли прицепить вагон
  # вынесен в private так как должен быть доступен
  # только внутри методов add_wagon и remove_wagon
  def can_attach?(wagon)
    @speed.zero? && type_match?(wagon)
  end

  # для лучшей читабельности метод can_attach?
  # имеет алиас can_detach?, который применяеться
  # для проверки того можно ли отцепить вагон
  alias can_detach? can_attach?

  # метод проверяет равен ли тип вагона типу поезда
  # вынесен в private так как должен быть доступен
  # только внутри метода can_attach?/can_detach?
  def type_match?(wagon)
    wagon.type == type
  end

  # метод который возвращает название начальной станции
  # вынесен в private т.к. метод
  # используеться только внутри метода show_forward_station
  def start_station_name
    @stations[0].name
  end

  # метод который возвращает название конечной станции
  # вынесен в private т.к. метод
  # используеться только внутри метода show_backward_station
  def end_station_name
    @stations[-1].name
  end

  # метод проверки начальной станции
  # вынесен в private т.к. метод
  # используеться только внутри метода show_forward_station
  def start_station?
    @station.zero?
  end

  # метод проверки конечной станции
  # вынесен в private т.к. метод
  # используеться только внутри метода show_backward_station
  def end_station?
    @station == @stations.size
  end

  # метод который возвращает название след. станции
  # вынесен в private т.к. метод
  # используеться только внутри метода show_forward_station
  def forward_station_name
    @stations[@station + 1].name
  end

  # метод который возвращает название пред. станции
  # вынесен в private т.к. метод
  # используеться только внутри метода show_backward_station
  def backward_station_name
    @stations[@station - 1].name
  end
end
