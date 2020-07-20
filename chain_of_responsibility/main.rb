# frozen_string_literal: true

# @abstract
class Handler
  attr_writer :next_handler

  def next_handler(handler)
    @next_handler = handler
    handler
  end

  # @abstract
  def handle(request)
    return @next_handler.handle(request) if @next_handler

    nil
  end
end

# Firefighters Handler
class FirefightersHandler < Handler
  def handle(request)
    request == 'Firefighters' ? 'Firefighters called' : super(request)
  end
end

# Police Handler
class PoliceHandler < Handler
  def handle(request)
    request == 'Police' ? 'Police called' : super(request)
  end
end

# Medical Handler
class MedicalHandler < Handler
  def handle(request)
    request == 'Medical' ? 'Medical called' : super(request)
  end
end

# Dispatcher Handler
class DispatcherHandler
  def handle(request)
    "Request (#{request}) passed to the Dispatcher"
  end
end

# configure chain
firefighters = FirefightersHandler.new
police = PoliceHandler.new
medical = MedicalHandler.new
dispatcher = DispatcherHandler.new

firefighters.next_handler(police)
            .next_handler(medical)
            .next_handler(dispatcher)

# handle
p firefighters.handle('Police') #=> "Police called"
p firefighters.handle('Medical') #=> "Medical called"
p firefighters.handle('X') #=> "Request (X) passed to the Dispatcher"
