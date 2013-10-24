require 'spec_helper'

describe Schedule do


  describe "do once" do
    let(:s) { Schedule.new(kind: :once, once_date: Date.today) }

    it { s.kind.should be :once }
    it { s.ice_cube.occurs_on?(Date.today).should be true }
    it { s.ice_cube.occurs_on?(Date.today + 1.year).should be false }
    it { s.ice_cube.occurs_on?(Date.yesterday).should be false }
  end

  describe "on yearly" do
    let(:s) { Schedule.new(kind: :yearly, yearly_date: Date.today) }

    it { s.ice_cube.occurs_on?(Date.today + 1.year).should be true }
    it { s.ice_cube.occurs_on?(Date.today + 1.year + 1.day).should be false }
  end

  describe "do monthly" do
    let(:d) { Date.new(2013, 10, 24)}
    let(:s) { Schedule.new(kind: :monthly, monthly_day: d.day) }

    it { s.ice_cube.occurs_on?(d).should be true }
    it { s.ice_cube.occurs_on?(d + 1.month).should be true }
    it { s.ice_cube.occurs_on?(d + 1.month + 1.day).should be false }
  end

  describe "for none" do
    let(:s) { Schedule.new(kind: :none) }

    it { s.ice_cube.should be nil }
  end
end