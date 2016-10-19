#!/usr/bin/env ruby

# Create a procedure to uppercase only
# Strings beginning with letter 'a' or 'A'.
# Proc returns original object if not String.
def bring_up
  proc { |x| x.is_a?(String) && x.start_with?('a', 'A') ? x.upcase : x }
end

# Create a procedure to multiple only
# values representing an Integer by two.
# Proc returns a string representation.
# Proc returns original string if not Integer-like.
def make_double
  proc { |x| x.to_s =~ /\A\d+\z/ ? (x.to_i * 2).to_s : x }
end

# Create a function to multiply all
# numbers in text by two.
# (Hint: use the previously defined procedure)
# Set of whitespaces should be changed to one space.
# (Hint: split and join is ok)

def increase_wage(contract)
  contract.split(' ').map(&make_double).join(' ')
end

# Run both of the created procedures
# and collect resulting array.

def process_text_array(array)
  array.map(&make_double).map(&bring_up)
end
