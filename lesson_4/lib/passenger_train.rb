# frozen_string_literal: true

class PassengerTrain < Train
  protected

  def type_match?(wagon)
    wagon.type == PASSENGER_TYPE
  end
end
