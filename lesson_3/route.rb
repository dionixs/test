# frozen_string_literal: true

class Route
  attr_reader :stations, :start_station, :end_station

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @stations = [start_station, end_station]
  end

  def add_station(station)
    @stations.insert(-2, station) unless station_included?(station)
  end

  def remove_station(station)
    return if station == @stations[0] || station == @stations[-1]

    @stations.delete(station) if station_included?(station)
  end

  def all_stations
    @stations.each_with_index { |station, i| puts "#{i + 1}: #{station.name}" }
  end

  private

  def station_included?(station)
    @stations.include?(station)
  end
end
