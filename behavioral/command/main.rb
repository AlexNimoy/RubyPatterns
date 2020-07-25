# frozen_string_literal: true

# Command
class Command
  # @abstract
  def execute(_reciver)
    raise NotImplementedError, "#{self.class} not implemented: #{__method__}"
  end
end

# Base Command
class BaseCommand < Command
  def execute(reciver)
    reciver.add_topping(self.class.to_s)
  end
end

%w[Cheese Bacon Pineapples Mushrooms Seafood].each do |topping|
  Object.const_set(topping, Class.new(BaseCommand))
end

# Reciver
class Reciver
  def initialize
    @toppings = []
  end

  def make
    @toppings.join(', ')
  end

  def add_topping(topping)
    @toppings << topping
  end
end

# Invorker
class Invorker
  def initialize(reciver)
    @reciver = reciver
    @commands = []
  end

  def add_command(command)
    @commands << command
  end

  def make_pizza
    @commands.each { |command| command.execute(@reciver) }
    @reciver.make
  end
end

reciver = Reciver.new
invorker = Invorker.new(reciver)

invorker.add_command(Cheese.new)
invorker.add_command(Bacon.new)
invorker.add_command(Pineapples.new)

p invorker.make_pizza #=> "Cheese, Bacon, Pineapples"
