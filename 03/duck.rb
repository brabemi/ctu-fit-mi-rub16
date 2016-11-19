#!/usr/bin/env ruby

# @TODO: define class Duck with constructor
# that takes as parameters `name` and `age` of
# the duck
class Duck
  @@num_quacks = 0

  protected

  attr_reader :age

  public

  attr_reader :name, :num_quacks
  def initialize(name, age)
    @name = name
    @age = age
    @flying = false
    @swimming = false
    @num_quacks = 0
  end

  def self.can_fly
    true
  end

  def flying?
    @flying
  end

  def flying=(state)
    @swimming = false if state
    @flying = state
  end

  def self.can_swim
    true
  end

  def swimming?
    @swimming
  end

  def swimming=(state)
    @flying = false if state
    @swimming = state
  end

  def quack
    @@num_quacks += 2
    @num_quacks += 2
    'quack quack'
  end

  def self.num_quacks
    @@num_quacks
  end

  def compare(other)
    return -1 if @age < other.age
    return 1 if @age > other.age
    0
  end

  def fly!
    self.flying = true
  end

  def swim!
    self.swimming = true
  end
end
