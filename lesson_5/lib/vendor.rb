# frozen_string_literal: true

module Vendor
  attr_reader :vendor_name

  def specify_vendor(name)
    self.vendor_name = name
  end

  protected

  attr_writer :vendor_name
end
