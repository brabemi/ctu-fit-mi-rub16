#!/usr/bin/env ruby

# Return array of odd elements from `array`
# in case that that a block is given, yield
# elements on odd index
# e.g.: [1,2,3,4,5,6] -> [2,4,6]
def odd_elements(array)
  odds = array.select.with_index { |_, i| i.odd? }
  return odds unless block_given?
  odds.map { |val| yield(val) }
end
