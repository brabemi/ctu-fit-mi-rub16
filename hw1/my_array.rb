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
    size.times { |i| yield @array[i] } if block_given?
    Enumerator.new do |y|
      size.times { |i| y << @array[i] }
    end
  end

  def reverse_each
    size.times { |i| yield @array[size - i - 1] } if block_given?
    Enumerator.new do |y|
      size.times { |i| y << @array[size - i - 1] }
    end
  end

  def reverse
    reverse_each.to_a
  end

  def reverse!
    @array = reverse
  end

  def pop
    retval = @array[size - 1]
    @array = @array[0...size - 1]
    retval
  end

  def select
    retval = []
    each { |e| retval.push(e) if yield e }
    retval
  end

  def map
    return each unless block_given?
    retval = []
    each { |e| retval.push(yield e) }
    retval
  end

  def clear
    @array = []
  end

  def include?(item)
    each { |e| return true if e == item }
    false
  end

  def max
    max = @array[0]
    each { |e| max = e if (e <=> max) == 1 } unless block_given?
    each { |e| max = e if (yield e, max) == 1 } if block_given?
    max
  end
end
