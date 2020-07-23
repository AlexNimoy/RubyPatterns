# frozen_string_literal: true

# @abstract
class Component
  attr_accessor :parent

  # @abstract
  def add(_component)
    raise NotImplementedError, "#{self.class} not implemented: #{__method__}"
  end

  def increment
    raise NotImplementedError, "#{self.class} not implemented: #{__method__}"
  end

  def decrement
    raise NotImplementedError, "#{self.class} not implemented: #{__method__}"
  end
end

# Leaf
class Leaf < Component
  def initialize
    @number = 2
  end

  def increment
    @number += 1
    "Leaf (#{@number})"
  end

  def decrement
    @number -= 1
    "Leaf (#{@number})"
  end
end

# Node
class Node < Component
  def initialize
    @children = []
    @number = 2
  end

  def add(component)
    @children << component
    component.parent = self
  end

  # @return [String]
  def increment
    @number += 1

    results = []
    @children.each do |child|
      results << child.increment
    end

    "Branch (#{@number}) [#{results}]"
  end

  def decrement
    @number -= 1

    results = []
    @children.each do |child|
      results << child.decrement
    end

    "Branch (#{@number}) [#{results}]"
  end
end

tree = Node.new

branch1 = Node.new
branch1.add(Leaf.new)
branch1.add(Leaf.new)

branch2 = Node.new
branch2.add(Leaf.new)

tree.add(branch1)
tree.add(branch2)

puts tree.increment
#=> Branch (3) [["Branch (3) [[\"Leaf (3)\", \"Leaf (3)\"]]", "Branch (3) [[\"Leaf (3)\"]]"]]

puts tree.decrement
#=> Branch (2) [["Branch (2) [[\"Leaf (2)\", \"Leaf (2)\"]]", "Branch (2) [[\"Leaf (2)\"]]"]]
