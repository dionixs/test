# frozen_string_literal: true

class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def take_train(train)
    @trains << train unless train_included?(train)
  end

  def send_train(train)
    @trains.delete(train) if train_included?(train)
  end

  def passenger_trains
    @trains.filter { |t| t.type == :passenger }.size
  end

  def cargo_trains
    @trains.filter { |t| t.type == :cargo }.size
  end

  private

  def train_included?(train)
    @trains.include?(train)
  end
end
