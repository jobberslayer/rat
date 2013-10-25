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
    let(:d) { Date.today }
    let(:s) { Schedule.new(kind: :monthly, monthly_day: d.day) }

    it "specific day" do 
      s.ice_cube.occurs_on?(d).should be true 
    end 
    it "specific day + 1 month" do 
      s.ice_cube.occurs_on?(d + 1.month).should be true 
    end 
    it "specific day + a month and a day" do 
      s.ice_cube.occurs_on?(d + 1.month + 1.day).should be false 
    end
  end

  describe "do 1st day of month" do
    let(:d) { Date.new((Date.today + 1.year).year, Date.today.month, 1) }
    let(:s) { Schedule.new(kind: :first_day_month) }

    it { s.ice_cube.occurs_on?(d).should be true } 
    it { s.ice_cube.occurs_on?(d + 1.day).should be false }
  end

  describe "do last day of month" do
    let(:d) { Date.new((Date.today + 1.year).year, Date.today.month, 1) - 1.day }
    let(:s) { Schedule.new(kind: :last_day_month) }

    it { s.ice_cube.occurs_on?(d).should be true } 
    it { s.ice_cube.occurs_on?(d + 1.day).should be false }
  end

  describe "for none" do
    let(:s) { Schedule.new(kind: :none) }

    it { s.ice_cube.should be nil }
  end
end