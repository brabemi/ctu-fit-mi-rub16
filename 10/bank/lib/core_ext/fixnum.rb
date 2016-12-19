#!/usr/bin/env ruby
# Fixnum extension
class Fixnum
  def to_money
    Money.new(self, :CZK)
  end
end
