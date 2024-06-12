# frozen_string_literal: true

class Wagon
  include Vendor

  PASSENGER_TYPE = :passenger
  CARGO_TYPE = :cargo

  attr_reader :type
end
