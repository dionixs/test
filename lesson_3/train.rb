# frozen_string_literal: true

class Train
  attr_reader :number, :type,
              :wagons, :speed

  TYPE = %i[passenger cargo].freeze

  def initialize(number, type, wagons)
    @number = number
    @type = type if TYPE.include?(type)
    @wagons = wagons
    @speed = 0
    @stations = []
    @station = 0
  end

  def go
    @speed = 50
  end

  def stop
    @speed = 0
  end

  def add_wagon
    @wagons += 1 if @speed.zero?
  end

  def remove_wagon
    @wagons -= 1 if @speed.zero?
  end

  def add_route(route)
    @stations = route.stations
  end

  def current_station
    @stations[@station].name
  end

  def forward_station
    @station.zero? ? @stations[0].name : @stations[@station + 1].name
  end

  def backward_station
    @station == @stations.size ? @stations[-1].name : @stations[@station - 1].name
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
end
