class CargoTrain < Train

  def initialize(number)
    super(number)
    @type = CARGO_TYPE
  end

  def go
    @speed = CARGO_SPEED
  end

  protected

  def type_match?(wagon)
    wagon.type == CARGO_TYPE
  end
end
