# frozen_string_literal: true

# very strange lib
class StrangeLib
  def verfahren_verursacht_seltsame_gefuhle
    'some'
  end

  def seltsame_methode_mit_langen_namen
    'namen'
  end
end

# Abstract Adapter
class Adapter
  def name
    raise NotImplementedError, "#{self.class} not implemented: #{__method__}"
  end

  def something
    raise NotImplementedError, "#{self.class} not implemented: #{__method__}"
  end
end

# Adapter implemented
class StrangeLibAdapter < Adapter
  def initialize
    @lib = StrangeLib.new
  end

  def name
    lib.seltsame_methode_mit_langen_namen
  end

  def something
    lib.verfahren_verursacht_seltsame_gefuhle
  end

  private

  attr_reader :lib
end

adapter = StrangeLibAdapter.new

p adapter.name
p adapter.something
