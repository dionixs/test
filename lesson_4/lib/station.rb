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

  def trains_by_type(type)
    @trains.filter { |t| t.type == type }.size
  end

  private

  # метод для проверки того находиться ли поезд на станции
  # вынесен в private т.к. метод должен быть доступен
  # для вызова только внутри методов take_train и send_train
  # и не должен быть доступен для вызова вне класса
  def train_included?(train)
    @trains.include?(train)
  end
end
