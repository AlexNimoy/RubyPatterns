# frozen_string_literal: true

# Singleton
class Singleton
  @instances = []
  10.times { @instances << new }

  class << self
    attr_reader :instances

    def instance
      @instances.sample
    end
  end

  private_class_method :new
end

# random instance
p Singleton.instance

# all instances
p Singleton.instances
