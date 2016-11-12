# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
def triangle(a, b, c)
  # WRITE THIS CODE
  if a+b <= c or a+c <= b or b+c <= a
    raise TriangleError
  end
  if a == b and b == c
    :equilateral
  elsif a == b or a == c or b == c
    :isosceles
  else
    :scalene
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
