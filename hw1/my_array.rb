#!/usr/bin/env ruby

# Immitates some behaviour of the Array class
#
# see: http://www.ruby-doc.org/core/Array.html
class MyArray
  def initialize(array = [])
    @array = array
  end

  def size
    @array.size
  end

  def each
    return @array.each unless block_given?
    @array.each { |item| yield item }
  end

  def reverse_each
    return @array.reverse_each unless block_given?
    @array.reverse_each { |item| yield item }
  end

  def reverse
    @array.reverse
  end

  def reverse!
    @array.reverse!
  end

  def pop
    @array.pop
  end

  def select
    return @array.select unless block_given?
    @array.select { |item| yield item }
  end

  def map
    return @array.map unless block_given?
    @array.map { |item| yield item }
  end

  def clear
    @array.clear
  end

  def include?(item)
    @array.include?(item)
  end

  def max
    return @array.max unless block_given?
    @array.max { |a, b| yield a, b }
  end
end
