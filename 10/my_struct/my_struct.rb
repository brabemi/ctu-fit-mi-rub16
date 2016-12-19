#!/usr/bin/env ruby
# Class behaving like an OpenStruct
class MyStruct
  def initialize(dict=nil)
    @dict = {}
    @size = dict != nil ? dict.size : 0
    define_singleton_method(:size) { @size }
    if dict != nil
      dict.each_pair do |k, v|
        k_sym = k.to_sym
        @dict[k_sym] = v
        define_singleton_method(k_sym) { @dict[k_sym] } unless respond_to?(k_sym)
      end
    end
  end

  def [](name)
    @dict[name.to_sym]
  end

  def []=(name, value)
    @dict[name.to_sym] = value
  end

  def each_pair
    return @dict.each_pair unless block_given?
    @dict.each_pair { |k, v| yield k, v }
  end

  def each_key
    return @dict.each_key unless block_given?
    @dict.each_key { |k| yield k }
  end

  def each_value
    return @dict.each_value unless block_given?
    @dict.each_value { |v| yield k, v }
  end
end
