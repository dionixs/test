# frozen_string_literal: true

class CargoTrain < Train
  def initialize(number)
    super
    @type = CARGO_TYPE
  end
end
