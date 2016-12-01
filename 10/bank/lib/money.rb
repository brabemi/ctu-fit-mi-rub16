#!/usr/bin/env ruby
require 'bigdecimal'
require_relative 'exchange_rates'
require_relative 'core_ext/string'
require_relative 'core_ext/fixnum'

# Money representation
class Money
  include Comparable

  attr_reader :value, :currency

  def initialize(value, currency = :CZK)
    @currency = currency.to_sym
    @value = BigDecimal.new(value)
  end

  def +(other)
    Money.new(@value + object_value(other), @currency)
  end

  def -(other)
    Money.new(@value - object_value(other), @currency)
  end

  def <=>(other)
    @value <=> object_value(other)
  end

  def eql?(other)
    self == other
  end

  def to_s
    "#{@value.to_f} #{@currency}"
  end

  private

  def object_value(money)
    if money.is_a?(Fixnum) || money.is_a?(Float)
      money
    else
      money_with_same_currency(money).value
    end
  end

  def money_with_same_currency(money)
    if @currency != money.currency
      value = ExchangeRates.change(money.value, money.currency, @currency)
      money = Money.new(value, @currency)
    end
    money
  end
end

# TODO: Define money conversion methods using metaprogramming
