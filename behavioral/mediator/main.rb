# frozen_string_literal: true

# Mediator
class Concierge
  def initialize(client:, service:)
    @client = client
    @client.mediator = self
    @service = service
    @service.mediator = self
  end

  def notify(_sender, event)
    case event
    when 'taxi', 'master', 'flower_delivery'
      @service.call
    when 'Taxi called', 'Master called', 'Flower delivery called'
      @client.notify(event)
    else
      'error'
    end
  end
end

# @abstract
class BaseComponent
  attr_accessor :mediator

  def initialize(mediator = nil)
    @mediator = mediator
  end
end

# Client
class Client < BaseComponent
  def call_taxi
    @mediator.notify(self, 'taxi')
  end

  def call_master
    @mediator.notify(self, 'master')
  end

  def call_flower_delivery
    @mediator.notify(self, 'flower_delivery')
  end

  def notify(message)
    message
  end
end

# Taxi service
class Taxi < BaseComponent
  def call
    @mediator.notify(self, 'Taxi called')
  end
end

# Master at home service
class MasterAtHome < BaseComponent
  def call
    @mediator.notify(self, 'Master called')
  end
end

# Flower delivery service
class FlowerDelivery < BaseComponent
  def call
    @mediator.notify(self, 'Flower delivery called')
  end
end

client = Client.new
Concierge.new(client: client, service: Taxi.new)
p client.call_taxi #=> "Taxi called"

client2 = Client.new
Concierge.new(client: client2, service: MasterAtHome.new)
p client2.call_master #=> "Master called"

client3 = Client.new
Concierge.new(client: client3, service: FlowerDelivery.new)
p client3.call_flower_delivery #=> "Flower delivery called"
