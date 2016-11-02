#!/usr/bin/env ruby

require 'forwardable'

module Summable
  def sum
    reduce(:+)
  end
end

class Array
  include Summable
end

# looks for vowels
class VowelFinder
  include Enumerable
  include Summable
  extend Forwardable
  def_delegators :@proccesed_data, :each, :<<
  def initialize(data)
    @proccesed_data = data.downcase.split('').select { |c| c =~ /\A[aeiyou]/ }
  end
end
