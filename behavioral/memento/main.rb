# frozen_string_literal: true

# Controller
class Originator
  def initialize(state)
    @state = state
  end

  def action(state)
    @state = state
  end

  def create_memento
    Memento.new(@state)
  end

  def restore(memento)
    @state = memento.state
  end

  private

  attr_accessor :state
end

# Snapshot
class Memento
  attr_reader :state

  def initialize(state)
    @state = state
  end
end

# Store
class Caretaker
  attr_reader :mementos

  def initialize(originator)
    @mementos = []
    @originator = originator
  end

  def backup
    @mementos << @originator.create_memento
  end

  def undo
    return if @mementos.empty?

    @originator.restore(@mementos.pop)
  end
end

originator = Originator.new('new document')
caretaker = Caretaker.new(originator)

caretaker.backup
originator.action('edit text')

caretaker.backup
originator.action('edit text2')

caretaker.backup

p caretaker.undo #=> "edit text2"
p caretaker.undo #=> "edit text"
