# frozen_string_literal: true

# Creator
class Oven
  def self.make_bake(bake)
    Object.const_get(bake).new.operation
  end
end

# Products
#
# Abstract Bake
class Bake
  # @abstract
  def operation
    raise NotImplementedError, "#{self.class} not implemented"
  end
end

# Pizza
class Pizza < Bake
  # @return [String]
  def operation
    'Pizza'
  end
end

# Pie
class Pie < Bake
  # @return [String]
  def operation
    'Pie'
  end
end

def client_code(creator, bake)
  creator.make_bake(bake)
end

p 'Make pizza'
p client_code(Oven, 'Pizza') # => "Pizza"

p 'Make pie'
p client_code(Oven, 'Pie') # => "Pie"
