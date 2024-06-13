# frozen_string_literal: true

class Station
  include InstanceCounter
  include Validatable

  attr_reader :name, :trains

  @@stations ||= []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    validate!
    register_instance
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

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise 'Station name cannot be blank' if name.nil?
    raise 'Station name must be between 2 and 50 characters long' if invalid_length?(name)
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
