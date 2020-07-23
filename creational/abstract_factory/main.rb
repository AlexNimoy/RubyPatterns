# frozen_string_literal: true

# Cafe
class Cafe
  def self.make_set_meal(kitchen)
    kitchen.make_set_meal
  end
end

# Abstract Kitchen
class Kitchen
  # @abstract
  def self.make_set_meal
    raise NotImplementedError, "#{self.class} not implemented: #{__method__}"
  end
end

# JapaneseKitchen
class JapaneseKitchen < Kitchen
  # @return [String]
  def self.make_set_meal
    JapaneseSetMeal.new.make
  end
end

# AmericanKitchen
class AmericanKitchen < Kitchen
  # @return [String]
  def self.make_set_meal
    AmericanSetMeal.new.make
  end
end

# UkrainianKitchen
class UkrainianKitchen < Kitchen
  # @return [String]
  def self.make_set_meal
    UkrainianSetMeal.new.make
  end
end

# Abstract SetMeal
class SetMeal
  # @abstract
  def make
    raise NotImplementedError, "#{self.class} not implemented: #{__method__}"
  end
end

# JapaneseSetMeal
class JapaneseSetMeal < SetMeal
  # @return [String]
  def make
    JapaneseDish.new.make
  end
end

# AmericanSetMeal
class AmericanSetMeal < SetMeal
  # @return [String]
  def make
    AmericanDish.new.make
  end
end

# UkrainianSetMeal
class UkrainianSetMeal < SetMeal
  # @return [String]
  def make
    UkrainianDish.new.make
  end
end

# Abstract Dish
class Dish
  # @abstract
  def make
    raise NotImplementedError, "#{self.class} not implemented: #{__method__}"
  end
end

# JapaneseDish
class JapaneseDish < Dish
  # @return [String]
  def make
    'Japanese Dish'
  end
end

# AmericanDish
class AmericanDish < Dish
  # @return [String]
  def make
    'American Dish'
  end
end

# UkrainianDish
class UkrainianDish < Dish
  # @return [String]
  def make
    'Ukrainian Dish'
  end
end

def client_code(kitchen)
  Cafe.make_set_meal(kitchen)
end

p 'Make Japanise set meal'
p client_code(JapaneseKitchen)

p 'Make American set meal'
p client_code(AmericanKitchen)

p 'Make Ukrainian set meal'
p client_code(UkrainianKitchen)
