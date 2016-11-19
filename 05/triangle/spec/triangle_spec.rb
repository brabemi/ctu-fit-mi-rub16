#!/bin/ruby
# -*- encoding : utf-8 -*-
require_relative 'spec_helper'
require_relative '../triangle'

describe 'Triangle' do
  context 'equilateral' do
    it { expect(triangle(10,10,10)).to eq :equilateral }
  end
  context 'isosceles' do
    it { expect(triangle(12,12,10)).to eq :isosceles }
    it { expect(triangle(10,12,12)).to eq :isosceles }
    it { expect(triangle(12,10,12)).to eq :isosceles }
  end
  context 'scalene' do
    it { expect(triangle(12,11,10)).to eq :scalene }
  end
  context 'not a triangle' do
    it { expect { triangle(10,1,1) }.to raise_error(TriangleError) }
    it { expect { triangle(1,10,1) }.to raise_error(TriangleError) }
    it { expect { triangle(1,1,10) }.to raise_error(TriangleError) }
  end
end
