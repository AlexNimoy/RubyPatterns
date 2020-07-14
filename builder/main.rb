# frozen_string_literal: true

# Pizza director
class Pizza
  attr_accessor :toppings

  def initialize
    @toppings = []
  end

  def add(topping)
    @toppings << topping
  end
end

# PizzaBuilder
class PizzaBuilder
  attr_reader :pizza

  TOPPINGS = %w[Cheese Bacon Pineapples Mushrooms Seafood].freeze

  def initialize
    @pizza = Pizza.new
  end

  TOPPINGS.each do |topping|
    define_method("add_#{topping.downcase}") do
      @pizza.add(topping)
    end
  end
end

builder = PizzaBuilder.new

# configure pizza
builder.add_cheese
builder.add_bacon
builder.add_mushrooms

pizza = builder.pizza
p pizza
