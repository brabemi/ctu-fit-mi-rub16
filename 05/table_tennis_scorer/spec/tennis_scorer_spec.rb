# -*- encoding : utf-8 -*-
require_relative 'spec_helper'
require_relative '../table_tennis_scorer'

describe TableTennisScorer do

  subject(:scorer) { TableTennisScorer.new }

  describe '#score'
  
    subject { scorer.score }

    context 'at the beginning' do
      it { is_expected.to eql '0-0' }
    end

    context 'server wins a point' do
      before do
        # ...
      end
      it { is_expected.to eql '1-0' }
    end

    context 'receiver wins a point' do
      it { is_expected.to eql '0-1' }
    end

    context 'both win a point' do
      it { is_expected.to eql '1-1' }
    end

    # ...
    
    context 'server wins a game' do
      # score of e.g. 10-7
      # server scores
      it { is_expected.to eql 'server game' }
    end
    
    context 'receiver wins a game' do
      # score of e.g. 7-10
      # receiver scores
      it { is_expected.to eql 'receiver game' }
    end
    
    context 'two point lead after deuce' do
      # game up to 10-10
      # server scores
      it { is_expected.to eql '11-10' }
      # receiver scores
      it { is_expected.to eql '11-11' }
      # server scores
      it { is_expected.to eql '12-11' }
      # server scores
      it { is_expected.to eql 'server game' }
    end
    
end
