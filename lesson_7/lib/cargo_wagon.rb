# frozen_string_literal: true

class CargoWagon < Wagon

  attr_accessor :total_volume
  attr_reader :busy_volume, :free_volume

  def initialize
    @type = CARGO_TYPE
    @busy_volume = 0
    super
    @free_volume = @total_volume
  end

  def take_volume(volume)
    return if free_volume.zero?

    self.busy_volume += volume if busy_volume != total_volume
    self.free_volume -= volume if free_volume.positive?

    return unless free_volume.negative?

    self.free_volume = 0
    self.busy_volume = @total_volume
  end

  protected

  def validate!
    super
    raise 'Type of wagon specified is not correct' if type != CARGO_TYPE
  end

  private

  attr_writer :busy_volume, :free_volume
end
