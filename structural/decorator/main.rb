# frozen_string_literal: true

# Abstract pizza interface
class PizzaInterface
  def make
    raise NotImplementedError, "#{self.class} not implemented: #{__method__}"
  end
end

# Thin Pizza base
class ThinPizzaBase < PizzaInterface
  def make
    'Thin crust'
  end
end

# Thick Pizza base
class ThickPizzaBase < PizzaInterface
  def make
    'Thick crust'
  end
end

# Topping base class
class Topping < PizzaInterface
  attr_accessor :subject

  # @param [Component] component
  def initialize(subject)
    @subject = subject
  end

  # @return [String]
  def make
    @subject.make
  end
end

# Cheese topping
class Cheese < Topping
  # @return [String]
  def make
    "Cheese, #{@subject.make}"
  end
end

# Bacon topping
class Bacon < Topping
  # @return [String]
  def make
    "Bacon, #{@subject.make}"
  end
end

# Pineapples topping
class Pineapples < Topping
  # @return [String]
  def make
    "Pineapples, #{@subject.make}"
  end
end

# Mushrooms topping
class Mushrooms < Topping
  # @return [String]
  def make
    "Mushrooms, #{@subject.make}"
  end
end

# Seafood topping
class Seafood < Topping
  # @return [String]
  def make
    "Seafood, #{@subject.make}"
  end
end

pizza_base = ThinPizzaBase.new

# add toppings
pizza = Mushrooms.new(
  Bacon.new(
    Cheese.new(pizza_base)
  )
)

# make Pizza
p pizza.make #=> "Mushrooms, Bacon, Cheese, Thin crust"

pizza_base = ThickPizzaBase.new

# add toppings
pizza = Seafood.new(
  Pineapples.new(
    Cheese.new(pizza_base)
  )
)

# make Pizza
p pizza.make #=> "Seafood, Pineapples, Cheese, Thick crust"
