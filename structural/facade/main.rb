# frozen_string_literal: true

require 'savon'

# Calculator
class Calculator
  ACTIONS = %i[add subtract multiply divide].freeze

  def initialize(client)
    @client = client
  end

  # @return [String, nil]
  ACTIONS.each do |action|
    define_method(action) do |a, b|
      response = @client.call(action, message: { intA: a, intB: b })
      response.body.dig("#{action}_response".to_sym, "#{action}_result".to_sym)
    end
  end
end

client = Savon.client(wsdl: 'http://www.dneonline.com/calculator.asmx?WSDL')
calc = Calculator.new(client)

p calc.add(2, 4)
p calc.subtract(6, 2)
p calc.multiply(3, 3)
p calc.divide(2, 2)
