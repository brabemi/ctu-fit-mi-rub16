#!/usr/bin/env ruby
$LOAD_PATH << './'
require 'cell'
# Contains sudoku game board
class Grid
  # Create Sudoku game grid of given dimension
  def initialize(dimension)
    @dimension = dimension
    @block_width = Math.sqrt(@dimension).to_i
    @grid = []
    @dimension.times do
      row = []
      @dimension.times { row.push(Cell.new(0, @dimension)) }
      @grid.push(row)
    end
  end

  # Return string with game board in a console friendly format
  def to_s(width = 3)
    separator = ''
    @dimension.times do |c|
      separator << '+' if c%width == 0 and c>0
      separator << '---'
    end
    separator << "\n"
    output = ''
    @dimension.times do |r|
      output << separator if r%width == 0
      line = ''
      @dimension.times do |c|
        line << '|' if c%width == 0 and c>0
        line << ' ' << (@grid[r][c].filled? ? @grid[r][c].value.to_s : ' ') << ' '
      end
      output << line << "\n"
    end
    output << separator
    output
  end

  # First element in the sudoku grid
  def first
    @grid.first.first
  end

  # Last element in the sudoku grid
  def last
    @grid.last.last
  end

  # Return value at given position
  def value(x, y)
    @grid[x][y].value
  end

  # Marks number +z+ which shouldn't be at position [x, y]
  def exclude(x, y, z)
    @grid[x][y].exclude(z)
  end

  # True when there is already a number
  def filled?(x, y)
    @grid[x][y].filled?
  end

  # True when no game was loaded
  def empty?
    @grid[x][y]
  end

  # Yields elements in given row
  def row_elems(x)
    # return @grid[x].each unless block_given?
    @grid[x].each { |item| yield item }
  end

  # Yields elements in given column
  def col_elems(y)
    @grid.each { |row| yield row[y] }
  end

  # Yields elements from block which is
  # containing element at given position
  def block_elems(x, y)
    row_start = x - x%@block_width
    col_start = y - y%@block_width
    for row in @grid[row_start..row_start+(@block_width-1)] do
      row[col_start..col_start+(@block_width-1)].each { |e| yield e }
    end
  end

  # With one argument return row, with 2, element
  # at given position
  def [](*args)
    return @grid[args[0]] if args.size == 1
    @grid[args[0]][args[1]]
  end

  # With one argument sets row, with 2 element
  def []=(*args)
    @dimension.times { |i| @grid[args[0]][i].value = args[1][i] } if args.size == 2
    @grid[args[0]][args[1]].value = args[2]
  end

  # Return number of missing numbers in grid
  def missing
    missing = 0
    each { |e| missing+=1 if e.filled? == false  }
    missing
  end

  # Number of filled cells
  def filled
    filled = 0
    each { |e| filled+=1 if e.filled?  }
    filled
  end

  # Number of rows in this sudoku
  def rows
    @dimension
  end

  # Number of columns in this sudoku
  def cols
    @dimension
  end

  # Iterates over all elements, left to right, top to bottom
  def each
    return @grid.collect(&:each).each unless block_given?
    @grid.each { |row| row.each { |cell| yield cell } }
  end

  # Return true if no filled number break sudoku rules
  def valid?
  end

  # Serialize grid values to a one line string
  def solution
  end
end
