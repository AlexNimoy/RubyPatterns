# frozen_string_literal: true

TOPPINGS = %w[Cheese Bacon Pineapples Mushrooms Seafood].freeze

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

# Generate toppings command classes
TOPPINGS.each do |topping|
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

# @abstract
class Expression
  def evaluate
    raise NotImplementedError, "#{self.class} not implemented: #{__method__}"
  end
end

# Base Expression
class BaseExpression < Expression
  def evaluate
    Object.const_get(self.class.to_s.chomp('Expression')).new
  end
end

# Generate Expression classes
TOPPINGS.each do |topping|
  Object.const_set("#{topping}Expression", Class.new(BaseExpression))
end

# Commands Parser
class Parser
  def initialize(invorker, str)
    @invorker = invorker
    @actions = str.split(', ')
  end

  def expression
    parse_commands.each { |command| @invorker.add_command(command.evaluate) }
    @invorker.make_pizza
  end

  def parse_commands
    @actions.map { |action| Object.const_get("#{action}Expression").new }
  end
end

reciver = Reciver.new
invorker = Invorker.new(reciver)

recipe = 'Cheese, Bacon, Pineapples, Mushrooms, Seafood'
expressions = Parser.new(invorker, recipe)

p expressions.expression
