# frozen_string_literal: true

class PassengerWagon < Wagon
  def initialize
    super
    @type = PASSENGER_TYPE
  end
end
