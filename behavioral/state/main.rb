# frozen_string_literal: true

# @abstract
class Oven
  # @param [State] state
  def initialize(state)
    transition_to(state)
  end

  def transition_to(state)
    puts "Oven: Transition to #{state.class}"
    @state = state
    @state.context = self
  end

  def bake
    @state.bake
  end

  def temp_up
    @state.temp_up
  end

  def temp_down
    @state.temp_down
  end

  private

  attr_accessor :state
end

# @abstract
class State
  attr_accessor :context

  # @abstract
  def temp_up
    raise NotImplementedError, "#{self.class} not implemented: #{__method__}"
  end

  # @abstract
  def temp_down
    raise NotImplementedError, "#{self.class} not implemented: #{__method__}"
  end

  # @abstract
  def bake
    raise NotImplementedError, "#{self.class} not implemented: #{__method__}"
  end
end

# Cold
class ColdState < State
  def temp_up
    @context.transition_to(ReadyState.new)
  end

  def temp_down
    puts 'Error: incorrect state'
  end

  def bake
    puts 'Error: too cold'
  end
end

# Ready
class ReadyState < State
  def temp_up
    @context.transition_to(OverheatState.new)
  end

  def temp_down
    @context.transition_to(ColdState.new)
  end

  def bake
    puts 'Make pizza'
  end
end

# Overheat
class OverheatState < State
  def temp_up
    puts 'Error: incorrect state'
  end

  def temp_down
    @context.transition_to(ReadyState.new)
  end

  def bake
    puts 'Error: too heat'
  end
end

oven = Oven.new(ColdState.new)

oven.bake #=> Error: too cold
oven.temp_up #=> Oven: Transition to ReadyState
oven.bake #=> Make pizza
oven.temp_up #=> Oven: Transition to OverheatState
oven.bake #=> Error: too heat
oven.temp_down #=> Oven: Transition to ReadyState
