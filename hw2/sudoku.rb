#!/bin/ruby
require 'set'
require_relative './grid'
require_relative './string_parser'

# Basic sudoku solver
class Sudoku
  PARSERS = [StringParser]

  EXCLUDE = proc do |enum, val|
    enum.each do |e|
      e.exclude(val)
    end
  end

  def initialize(game)
    @grid = load(game)
  end

  # Return true when there is no missing number
  def solved?
    !@grid.nil? && @grid.missing == 0
  end

  # Solves sudoku and returns 2D Grid
  def solve
    algorithm_X
    fail 'invalid game given' unless @grid.valid?
    puts "missing values #{@grid.missing}, filled #{@grid.filled}"
  end

  def solution
     @grid.solution
  end

  protected

  def load(game)
    PARSERS.each do |p|
      return p.load(game) if p.supports?(game)
    end
    fail "input '#{game}' is not supported yet"
  end

  def algorithm_X
    dimension = @grid.dimension
    block_width = @grid.block_width
    nodes = Hash.new()

    dimension.times do |r|
      dimension.times do |c|
        nodes[{r: r, c: c}] = Set.new
        dimension.times {|i| nodes[{r: r, c: c}].add(i+1)} if @grid.filled?(r,c) == false
      end
    end

    dimension.times do |r|
      dimension.times do |c|
        if @grid.filled?(r,c)
          i = @grid.value(r,c)
          rs = r - r%block_width
          cs = c - c%block_width
          colisions = []
          dimension.times {|r1| colisions.push({r: r1, c: c})}
          dimension.times {|c1| colisions.push({r: r, c: c1})}
          (rs...rs+block_width).each do |r1|
            (cs...cs+block_width).each {|c1| colisions.push({r: r1, c: c1})}
          end
          colisions.each {|k| nodes[k].delete(i)}
        end
      end
    end

    node = nodes.min_by {|e| e[1].size == 0 ? 81 : e[1].size }
    # steps = 81
    # while node[1].size == 1 and steps > 0 do
    while node[1].size == 1 do
      i = node[1].to_a[0]
      r = node[0][:r]
      c = node[0][:c]
      rs = r - r%block_width
      cs = c - c%block_width
      colisions = []
      dimension.times {|r1| colisions.push({r: r1, c: c})}
      dimension.times {|c1| colisions.push({r: r, c: c1})}
      (rs...rs+block_width).each do |r1|
        (cs...cs+block_width).each {|c1| colisions.push({r: r1, c: c1})}
      end
      colisions.each {|k| nodes[k].delete(i)}
      @grid[r,c] = i
      # steps -= 1
      node = nodes.min_by {|e| e[1].size == 0 ? 81 : e[1].size }
    end
    # p nodes
    # print @grid.to_s
    # print nodes
    # p nodes.min_by {|e| e[1].size == 0 ? 81 : e[1].size }
  end

end
