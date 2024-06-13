# frozen_string_literal: true

class CargoTrain < Train
  def initialize(number)
    super
    @type = CARGO_TYPE
    validate!
  end

  protected

  def validate!
    super
    raise 'Type of train specified is not correct' if type != CARGO_TYPE
  end
end
