#!/usr/bin/env ruby
require_relative 'slide'

class Presentation

  attr_reader :num_slides

  def initialize(dsl)
    @num_slides = 0
    @author = nil
    @title = nil
    @theme = nil
    @data = []
    @actual_slide = nil
    instance_eval dsl
  end

  def to_s
    output = ''
    output << '\documentclass[12pt]{beamer}' << "\n"
    output << '\setbeamertemplate{navigation symbols}{}' << "\n"
    output << "\\usetheme{#{@theme}}\n" if @theme
    output << "\\title{#{@title}}\n" if @title
    output << "\\author{#{@author}}\n" if @author
    output << '\date{\today}' << "\n"
    output << "\n"
    output << '\begin{document}' << "\n"
    if @title and @author
      output << '\begin{frame}' << "\n"
      output << '\titlepage' << "\n"
      output << '\end{frame}' << "\n"
    end
    @data.each do |e|
      output << e.to_s << "\n"
    end
    output << '\end{document}' << "\n"
  end

  private
  def title(title)
    if @actual_slide
      @actual_slide.title = title
    else
      @title = title
    end
  end

  def author(author)
    @author = author
  end

  def theme(theme)
    @theme = theme
  end

  def section(section)
    @data.push("\\section{#{section}}\n")
  end

  def item(item)
    @actual_slide.items.push(item)
  end

  def slide(&block)
    @num_slides += 1
    @actual_slide = Slide.new
    @data.push(@actual_slide)
    instance_eval &block
  end
end
