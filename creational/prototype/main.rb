# frozen_string_literal: true

# Car main class
class Car
  attr_accessor :color, :number

  CARS = [
    { type: 'passenger', weight: 2.5 },
    { type: 'lorry', weight: 5.6 },
    { type: 'minivan', weight: 3.0 }
  ].freeze

  CARS.each do |car|
    define_method(car[:type]) do |**options|
      prototype = clone
      prototype.tap { |p| p.weight = car[:weight] }
               .tap { |p| p.color = options[:color] || 'white' }
               .tap { |p| p.number = options[:number] || '000' }
    end
  end

  protected

  attr_accessor :weight
end

car = Car.new

p car.passenger(color: 'black', number: '001')
p car.lorry(color: 'red')
p car.minivan(number: '999')
