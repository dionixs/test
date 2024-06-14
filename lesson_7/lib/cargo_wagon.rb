# frozen_string_literal: true

class CargoWagon < Wagon
  def initialize
    @type = CARGO_TYPE
    super
  end

  protected

  def validate!
    super
    raise 'Type of wagon specified is not correct' if type != CARGO_TYPE
  end
end
