# frozen_string_literal: true

# Abstract Dish
class Dish
  def initialize(kitchen)
    @kitchen = kitchen
  end

  # @abstract
  def make
    raise NotImplementedError, "#{self.class} not implemented: #{__method__}"
  end
end

# FirstDish
class FirstDish < Dish
  def make
    @kitchen.serve('first dish')
  end
end

# SecondDish
class SecondDish < Dish
  def make
    @kitchen.serve('second dish')
  end
end

# ThirdDish
class ThirdDish < Dish
  def make
    @kitchen.serve('third dish')
  end
end

# DessertDish
class DessertDish < Dish
  def make
    @kitchen.serve('dessert dish')
  end
end

# Abstract Kitchen
class Kitchen
  # @abstract
  def self.serve(_dash)
    raise NotImplementedError, "#{self.class} not implemented: #{__method__}"
  end
end

# JapaneseKitchen
class JapaneseKitchen < Kitchen
  # @return [String]
  def self.serve(dash)
    "JapaneseKitchen #{dash}"
  end
end

# AmericanKitchen
class AmericanKitchen < Kitchen
  # @return [String]
  def self.serve(dash)
    "AmericanKitchen #{dash}"
  end
end

# UkrainianKitchen
class UkrainianKitchen < Kitchen
  # @return [String]
  def self.serve(dash)
    "UkrainianKitchen #{dash}"
  end
end

p FirstDish.new(JapaneseKitchen).make # => "JapaneseKitchen first dish"
p SecondDish.new(AmericanKitchen).make # => "AmericanKitchen second dish"
p ThirdDish.new(UkrainianKitchen).make # => "UkrainianKitchen third dish"
p DessertDish.new(JapaneseKitchen).make # => "JapaneseKitchen dessert dish"
