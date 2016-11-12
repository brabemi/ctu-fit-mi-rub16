# -*- encoding : utf-8 -*-
require_relative 'spec_helper'
require_relative '../table_tennis_scorer'

describe TableTennisScorer do
  subject(:scorer) { TableTennisScorer.new }

  describe '#score'

  subject { scorer.score }

  before(:each) do
    scorer.reset
  end

  context 'at the beginning' do
    it { is_expected.to eql '0-0' }
  end

  context 'server wins a point' do
    it do
      scorer.srv_score
      is_expected.to eql '1-0'
    end
  end

  context 'receiver wins a point' do
    it do
      scorer.rec_score
      is_expected.to eql '0-1'
    end
  end

  context 'both win a point' do
    it do
      scorer.srv_score
      scorer.rec_score
      is_expected.to eql '1-1'
    end
  end

  context 'server wins a game' do
    # score of e.g. 10-7
    # server scores
    before do
      10.times do
        scorer.srv_score
      end
      7.times do
        scorer.rec_score
      end
    end
    it do
      scorer.srv_score
      is_expected.to eql 'server game'
    end
  end

  context 'receiver wins a game' do
    # score of e.g. 7-10
    # receiver scores
    before do
      7.times do
        scorer.srv_score
      end
      10.times do
        scorer.rec_score
      end
    end
    it do
      scorer.rec_score
      is_expected.to eql 'receiver game'
    end
  end

  context 'two point lead after deuce' do
    # game up to 10-10
    before :all do
      @scorer = TableTennisScorer.new
      10.times do
        @scorer.srv_score
      end
      10.times do
        @scorer.rec_score
      end
    end

    it do
      # server scores
      @scorer.srv_score
      expect(@scorer.score).to eq '11-10'
    end
    it do
      # receiver scores
      @scorer.rec_score
      expect(@scorer.score).to eq '11-11'
    end
    it do
      # server scores
      @scorer.srv_score
      expect(@scorer.score).to eq '12-11'
    end
    it do
      # server scores
      @scorer.srv_score
      expect(@scorer.score).to eq 'server game'
    end
  end
end
