# frozen_string_literal: true

class CargoWagon < Wagon
  def initialize
    super
    @type = CARGO_TYPE
  end
end
