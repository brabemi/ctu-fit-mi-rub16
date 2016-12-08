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

  def algorithm_X
    dimension = @grid.dimension
    block_width = @grid.block_width
    nodes = Hash.new()
    dimension.times do |i|
      dimension.times { |r| nodes[{r: r, v: i+1}] = Set.new }
      dimension.times { |c| nodes[{c: c, v: i+1}] = Set.new }
      dimension.times { |b| nodes[{b: b, v: i+1}] = Set.new }
    end
    options = Set.new
    dimension.times do |r|
      dimension.times do |c|
        if @grid.filled?(r,c) == false
          dimension.times do |i|
            b = r - r%block_width + c/block_width
            options.add({r: r, c: c, b: b, v: i+1})
            # p({r: r, c: c, b: b, v: i+1}.to_s)
            nodes[{r: r, v: i+1}].add({r: r, c: c, b: b, v: i+1})
            nodes[{c: c, v: i+1}].add({r: r, c: c, b: b, v: i+1})
            nodes[{b: b, v: i+1}].add({r: r, c: c, b: b, v: i+1})
          end
        end
      end
    end

    dimension.times do |r|
      dimension.times do |c|
        if @grid.filled?(r,c)
          i = @grid.value(r,c)
          b = r - r%block_width + c/block_width
          colisions = nodes[{r: r, v: i}].flatten.merge(nodes[{c: c, v: i}]).merge(nodes[{b: b, v: i}])
          # p colisions
          colisions.each do |e|
            nodes[{r: e[:r], v: e[:v]}].delete(e)
            nodes[{c: e[:c], v: e[:v]}].delete(e)
            nodes[{b: e[:b], v: e[:v]}].delete(e)
          end
        end
      end
    end

  print @grid.to_s
  node = nodes.min_by {|e| e[1].size == 0 ? 81 : e[1].size }
  steps = 30
  while node[1].size == 1 and steps > 0 do
    my_sol = node[1].to_a[0]
    # p my_sol
    r = my_sol[:r]
    c = my_sol[:c]
    b = my_sol[:b]
    i = my_sol[:v]
    colisions = nodes[{r: r, v: i}].flatten.merge(nodes[{c: c, v: i}]).merge(nodes[{b: b, v: i}])
    # p colisions
    colisions.each do |e|
      nodes[{r: e[:r], v: e[:v]}].delete(e)
      nodes[{c: e[:c], v: e[:v]}].delete(e)
      nodes[{b: e[:b], v: e[:v]}].delete(e)
    end
    @grid[r,c] = i
    steps -= 1
    node = nodes.min_by {|e| e[1].size == 0 ? 81 : e[1].size }
  end
  p nodes

  print @grid.to_s
  # print nodes
  # p nodes.min_by {|e| e[1].size == 0 ? 81 : e[1].size }

  end

  # Solves sudoku and returns 2D Grid
  def solve
    algorithm_X
    fail 'invalid game given' unless @grid.valid?
    puts "missing values #{@grid.missing}, filled #{@grid.filled}"
  end

  protected

  def load(game)
    PARSERS.each do |p|
      return p.load(game) if p.supports?(game)
    end
    fail "input '#{game}' is not supported yet"
  end
end
