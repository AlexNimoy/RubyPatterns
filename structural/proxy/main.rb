# frozen_string_literal: true

require 'savon'

# @abstract
class Subject
  ACTIONS = %i[add subtract multiply divide].freeze

  # @abstract
  ACTIONS.each do |action|
    define_method(action) do |_a, _b|
      raise NotImplementedError, "#{self.class} not implemented: #{__method__}"
    end
  end
end

# Calculator
class Calculator < Subject
  def initialize(client)
    @client = client
  end

  ACTIONS.each do |action|
    define_method(action) do |a, b|
      response = @client.call(action, message: { intA: a, intB: b })
      response.body.dig("#{action}_response".to_sym, "#{action}_result".to_sym)
    end
  end
end

# Proxy
class CacheProxy < Subject
  def initialize(real_subject)
    @real_subject = real_subject
    @cache = []
  end

  ACTIONS.each do |action|
    define_method(action) do |a, b|
      result_from_cache(__method__.to_s, a, b)
    end
  end

  private

  def result_from_cache(method, a, b)
    cache_search(method, a, b).tap { |cache| return cache[:result] if cache }

    @real_subject
      .public_send(method, a, b)
      .tap { |res| add_to_cache(method, a, b, res) }
  end

  def cache_search(method, a, b)
    @cache.find { |i| i[:method] == method && i[:a] == a && i[:b] == b }
  end

  def add_to_cache(method, a, b, result)
    @cache << { method: method, a: a, b: b, result: result }
  end
end

client = Savon.client(wsdl: 'http://www.dneonline.com/calculator.asmx?WSDL')
calc = Calculator.new(client)
proxy = CacheProxy.new(calc)

p proxy.add(2, 4)
p calc.subtract(6, 2)

p proxy.add(2, 4) #=> result from cache
p calc.subtract(6, 2) #=> result from cache
