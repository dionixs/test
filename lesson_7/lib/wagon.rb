# frozen_string_literal: true

class Wagon
  include Validatable
  include Vendor

  PASSENGER_TYPE = :passenger
  CARGO_TYPE = :cargo

  attr_reader :type, :number

  def initialize
    @number = generate_number
    yield self if block_given?
    validate!
  end

  protected

  def validate!
    raise NotImplementedError, 'Unable to create an object of a Class that is a parent!' if instance_of?(Wagon)
    raise 'Vendor name must be between 2 and 50 characters long' if !vendor_name.nil? && invalid_length?(vendor_name)
  end

  private

  def generate_number
    rand(10_000..100_000)
  end
end
