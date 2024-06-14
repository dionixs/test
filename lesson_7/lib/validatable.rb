# frozen_string_literal: true
module Validatable

  def valid?
    validate!
    true
  rescue NotImplementedError
    false
  rescue StandardError
    false
  end

  private

  def invalid_length?(attr, min_length = 2, max_length = 50)
    attr.size < min_length || attr.size > max_length
  end
end
