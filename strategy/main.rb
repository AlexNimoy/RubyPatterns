# frozen_string_literal: true

# Context
class Context
  def initialize(strategy)
    @strategy = strategy
  end

  def sort_with_strategy(array)
    @strategy.execute(array)
  end
end

# @abstract
class Strategy
  # @abstract
  def execute(_array)
    raise NotImplementedError, "#{self.class} not implemented: #{__method__}"
  end
end

# Bubble sort
class BubbleSortStrategy < Strategy
  def execute(array)
    return [] if array.empty?

    left, right = array[1..-1].partition { |y| y <= array.first }
    execute(left) + [array.first] + execute(right)
  end
end

# Quick sort
class QuickSortStrategy < Strategy
  def execute(array)
    swapped = true
    while swapped
      swapped = false
      0.upto(array.size - 2) do |i|
        if array[i] > array[i + 1]
          array[i], array[i + 1] = array[i + 1], array[i]
          swapped = true
        end
      end
    end
    array
  end
end

array = %w[1 3 2 4 5 8 7 9 6]

context = Context.new(BubbleSortStrategy.new)
p context.sort_with_strategy(array)

context = Context.new(QuickSortStrategy.new)
p context.sort_with_strategy(array)
