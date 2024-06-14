# frozen_string_literal: true

class PassengerWagon < Wagon
  def initialize
    @type = PASSENGER_TYPE
    super
  end

  protected

  def validate!
    super
    raise 'Type of wagon specified is not correct' if type != PASSENGER_TYPE
  end
end
