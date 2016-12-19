#!/usr/bin/env ruby

class Slide
  attr_accessor :items, :title
  def initialize
    @items = []
    @title = ''
  end

  def to_s
    output = ''
    output << "\\begin{frame}{#{@title}}\n"
    output << '\begin{itemize}' << "\n"
    @items.each { |e| output << "\\item #{e}\n" }
    output << '\end{itemize}' << "\n"
    output << '\end{frame}'
  end
end
