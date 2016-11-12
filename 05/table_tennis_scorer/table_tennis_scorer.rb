# -*- encoding : utf-8 -*-
class TableTennisScorer
  def initialize
    @srv_score = 0
    @rec_score = 0
  end

  def score
    if (@srv_score < 11 && @rec_score < 11) || (@srv_score - @rec_score).abs < 2
      "#{@srv_score}-#{@rec_score}"
    elsif @srv_score > @rec_score
      'server game'
    else
      'receiver game'
    end
  end

  def srv_score
    @srv_score += 1
  end

  def rec_score
    @rec_score += 1
  end

  def reset
    @srv_score = 0
    @rec_score = 0
  end
end
