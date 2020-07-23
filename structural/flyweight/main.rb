# frozen_string_literal: true

# Unit
class Unit
  attr_accessor :x, :y
  def initialize(shared, unit_type)
    @shared = shared
    @unit_type = unit_type
  end
end

# Shared data for Cavalry
class UnitCavalryShared
  def initialize
    @name = 'cavalry'
    @sprite = 'sp.jpg'
    @sound = 'igogo.mp3'
    @speep = 10
    @horse_texture = 'horse.jpg'
  end
end

# Shared data for Infantry
class UnitInfantryShared
  def initialize
    @name = 'Infantry'
    @sprite = 'in.jpg'
    @sound = 'ura.mp3'
    @speep = 5
  end
end

# Army actions
class Army
  attr_reader :units

  def initialize(units)
    @units = units
  end

  def move(x_coordinate, y_coordinate)
    @units.each do |unit|
      unit.x = x_coordinate
      unit.y = y_coordinate
    end
  end
end

# shared data
cavalry_shared = UnitCavalryShared.new
infantry_shared = UnitInfantryShared.new

# create units
cavalry_unit = Unit.new(cavalry_shared, 'cavalry')
cavalry_unit.x = 1
cavalry_unit.y = 2

infantry_unit = Unit.new(infantry_shared, 'infantry')
infantry_unit.x = 2
infantry_unit.y = 2

# group army
army = Army.new([cavalry_unit, infantry_unit])

# move
army.move(5, 5)

p army.units
