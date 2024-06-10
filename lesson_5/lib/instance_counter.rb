# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods

    # ||= это шорткат @instances = @instances || 0
    def instances
      @instances ||= 0
    end

    private

    attr_writer :instances
  end

  module InstanceMethods
    private

    def register_instance
      current_instances = self.class.instances
      # для получения доступа к instances= в private
      # используем send
      self.class.send(:instances=, current_instances + 1)
    end
  end
end
