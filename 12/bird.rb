class Bird
  def initialize(x, y, pig, score)
    @x, @y = x, y
    @img = Gosu::Image.new('media/bird.png')
    @pig = pig
    @hidden = false
    @score = score
  end

  def draw
    @img.draw(@x, @y, 1) unless @hidden
  end

  def update_delta(delta)
    unless @hidden
      x_delta = ((@x + 34) - (@pig.x + 63))
      y_delta = ((@y + 50) - (@pig.y + 99))
      len = Math.sqrt(x_delta**2 + y_delta**2)
      if len < 100
        x_run = (x_delta / len) * delta * 90
        y_run = (y_delta / len) * delta * 90
        if ((x_delta + x_run.abs)**2 + (y_delta + y_run.abs)**2) < 7100
          hide()
        else
          @x += x_run
          @y += y_run
        end
      end
    end
  end

  def hide
    unless @hidden
      @hidden = true
      @score.increase
    end
  end
end
