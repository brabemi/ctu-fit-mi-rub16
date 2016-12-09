#!/usr/bin/env ruby
class Roman
  include Comparable
  MAX_ROMAN = 4999
  FACTORS = [['m', 1000], ['cm', 900], ['d', 500], ['cd', 400],
             ['c', 100], ['xc', 90], ['l', 50], ['xl', 40],
             ['x', 10], ['ix', 9], ['v', 5], ['iv', 4],
             ['i', 1]]
  attr_accessor :value, :roman
  alias to_i value
  alias to_int value
  alias to_s roman
  alias to_str roman
  def initialize(value)
    if value <= 0 || value > MAX_ROMAN
      raise 'Roman values must be > 0 and <= #{MAX_ROMAN}'
    end
    @value = value
    @roman = to_roman
  end

  def to_roman
    value = @value
    roman = ''
    FACTORS.each do |code, factor|
      count, value = value.divmod(factor)
      count.times do
        roman << code
      end
    end
    roman
  end

  def coerce(other)
    [other, @value]
  end

  def +(other)
    @value + other.to_i
  end

  def *(other)
    @value * other.to_i
  end

  def -(other)
    @value - other.to_i
  end

  def /(other)
    @value / other.to_i
  end

  def <=>(other)
    if other.instance_of? Float
      Float(@value) <=> other
    else
      @value <=> other.to_i
    end
  end

  def eql?(other)
    other.instance_of?(self.class) && @value == other.to_i
  end
end
