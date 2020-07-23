# frozen_string_literal: true

# @abstract
class Template
  FILE_NAME = 'tmp.txt'

  def write_file
    File.open(FILE_NAME, 'w') do |file|
      file.write(data_to_write)
    end
  end

  # @abstract
  def data_to_write
    raise NotImplementedError, "#{self.class} not implemented: #{__method__}"
  end
end

# Write current date
class DateWriter < Template
  def data_to_write
    Time.now.strftime('%F') #=> 2020-07-22
  end
end

# Write current time
class TimeWriter < Template
  def data_to_write
    Time.now.strftime('%T') #=> 08:37:48
  end
end

DateWriter.new.write_file
TimeWriter.new.write_file
