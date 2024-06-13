module Validatable

  private

  def invalid_length?(attr, min_length = 2, max_length = 50)
    attr.size < min_length || attr.size > max_length
  end
end
