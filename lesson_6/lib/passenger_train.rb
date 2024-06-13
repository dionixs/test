# frozen_string_literal: true

class PassengerTrain < Train
  def initialize(number)
    super
    @type = PASSENGER_TYPE
    validate!
  end

  protected

  def validate!
    super
    raise 'Type of train specified is not correct' if type != PASSENGER_TYPE
  end
end
