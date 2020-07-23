# frozen_string_literal: true

# Array custom pluck method
class Array
  def pluck(key)
    map { |h| h[key] }
  end
end

# Base Itertor
class BaseIterator
  include Enumerable

  def initialize(collection)
    @collection = collection
  end

  def each(_block)
    raise NotImplementedError, "#{self.class} not implemented: #{__method__}"
  end
end

# Author Name Iterator
class BooksAuthorsIterator < BaseIterator
  def each(&block)
    @collection.pluck(:author).sort.each(&block)
  end
end

# Tetles Iterator
class BooksTitlesIterator < BaseIterator
  def each(&block)
    @collection.pluck(:title).sort.each(&block)
  end
end

# Years Iterator
class BooksYearsIterator < BaseIterator
  def each(&block)
    @collection.pluck(:year).sort.each(&block)
  end
end

# Books
class BookCollection
  attr_reader :collection

  def initialize
    @collection = []
  end

  # @return [Iterator]
  def authors_iterator
    BooksAuthorsIterator.new(@collection)
  end

  # @return [Iterator]
  def years_iterator
    BooksYearsIterator.new(@collection)
  end

  # @return [Iterator]
  def titles_iterator
    BooksTitlesIterator.new(@collection)
  end

  def add_item(author:, title:, year:)
    @collection << { author: author, title: title, year: year }
  end
end

collection = BookCollection.new
collection.add_item(author: 'Мартин Фаулер',
                    title: 'Рефакторинг кода на JavaScript',
                    year: '2019')

collection.add_item(author: 'Кент Бек',
                    title: 'Экстремальное программирование.',
                    year: '2003')

collection.add_item(author: 'Робурет Мартин',
                    title: 'Чистый код.',
                    year: '2012')

# Authors
p 'Authors'
collection.authors_iterator.each { |name| p name }

# Titles
p 'Titles'
collection.titles_iterator.each { |title| p title }

# Years
p 'Years'
collection.years_iterator.each { |year| p year }
