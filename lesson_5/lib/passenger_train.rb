# frozen_string_literal: true

class PassengerTrain < Train
  def initialize(number)
    super
    @type = PASSENGER_TYPE
  end
end
