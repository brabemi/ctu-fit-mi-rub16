#!/bin/ruby
$LOAD_PATH << './'
require 'grid'
# Parse string for 9x9 sudoku game
#
class StringParser
  # Static methods will follow
  class << self
    # Return true if passed object
    # is supported by this loader
    def supports?(arg)
      arg.kind_of? String and arg.size == 81 and (arg =~ /[\d\.]{#{arg.size}}/) != nil
    end

    # Return Grid object when finished
    # parsing
    def load(arg)
      nil if supports?(arg) == false
      dim = Math.sqrt(arg.size).to_i
      grid = Grid.new(dim)
      potatoes = ['0', '.']
      dim.times do |r|
        dim.times {|c| grid[r,c] = (potatoes.include? arg[r*dim+c]) ? 0 : arg[r*dim+c].to_i }
      end
      grid
    end
  end
end
