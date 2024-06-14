# frozen_string_literal: true

class PassengerWagon < Wagon

  attr_accessor :total_seats
  attr_reader :busy_seats, :free_seats

  def initialize
    @type = PASSENGER_TYPE
    @busy_seats = 0
    super
    @free_seats = @total_seats
  end

  # метод, который "занимает места" в вагоне (по одному за раз)
  def take_seat
    self.busy_seats += 1 if busy_seats != total_seats
    self.free_seats -= 1 if free_seats != 0
  end

  protected

  def validate!
    super
    raise 'Type of wagon specified is not correct' if type != PASSENGER_TYPE
  end

  private

  attr_writer :free_seats, :busy_seats
end
