# frozen_string_literal: true

# @abstract
class Component
  def accept(visitor)
    visitor.public_send("add_#{self.class.to_s.downcase}", self)
  end

  def visit
    self.class.to_s
  end
end

class Cheese < Component
end

class Bacon < Component
end

class Pineapples < Component
end

class Mushrooms < Component
end

class Seafood < Component
end

# @abstract
class Visitor
  TOPPINGS = %w[Cheese Bacon Pineapples Mushrooms Seafood].freeze

  TOPPINGS.each do |topping|
    define_method("add_#{topping.downcase}") do
      raise NotImplementedError, "#{self.class} not implemented: #{__method__}"
    end
  end
end

# Thin pizza base
class PizzaThinCrust < Visitor
  TOPPINGS.each do |topping|
    define_method("add_#{topping.downcase}") do |element|
      element.visit
    end
  end
end

def client_code(components, visitor)
  components.map do |component|
    component.accept(visitor)
  end
end

components = [
  Cheese.new,
  Bacon.new,
  Pineapples.new,
  Mushrooms.new,
  Seafood.new
]

p client_code(components, PizzaThinCrust.new).join(', ')
#=> "Cheese, Bacon, Pineapples, Mushrooms, Seafood"
