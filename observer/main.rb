# frozen_string_literal: true

# Subject
class Subject
  attr_accessor :level

  def initialize
    @observers = []
  end

  def attach(observer)
    @observers << observer
  end

  def detach(observer)
    @observers.delete(observer)
  end

  def notify
    @observers.each { |observer| observer.update(self) }
  end

  def wind(level)
    @level = level
    notify
  end
end

# @abstract
class Observer
  # @abstract
  def update(_subject)
    raise NotImplementedError, "#{self.class} not implemented: #{__method__}"
  end
end

# Schools Observer
class SchoolsObserver < Observer
  def update(subject)
    puts 'School reacted to the notify' if subject.level >= 3
  end
end

# Airport Observer
class AirportObserver < Observer
  def update(subject)
    puts 'Airport reacted to the notify' if subject.level >= 2
  end
end

# RoadServicesObserver
class RoadServicesObserver < Observer
  def update(subject)
    puts 'RoadServices reacted to the notify' if subject.level >= 4
  end
end

# C=onfigure
subject = Subject.new

schools = SchoolsObserver.new
subject.attach(schools)

airport = AirportObserver.new
subject.attach(airport)

road_services = RoadServicesObserver.new
subject.attach(road_services)

# Notify
subject.wind(2)
#=> Airport reacted to the notify

subject.wind(3)
#=> School reacted to the notify
#=> Airport reacted to the notify

subject.wind(4)
#=> School reacted to the notify
#=> Airport reacted to the notify
#=> RoadServices reacted to the notify

