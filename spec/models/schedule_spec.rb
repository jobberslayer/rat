require 'spec_helper'

describe Schedule do


  describe "do once" do
    let(:s) { Schedule.new(kind: :once, once_date: Date.today) }

    it { s.should be_occurs_on(Date.today) }
    it { s.should_not be_occurs_on(Date.today + 1.year) }
    it { s.should_not be_occurs_on(Date.yesterday) }
  end

  describe "on yearly" do
    let(:s) { Schedule.new(kind: :yearly, yearly_date: Date.today) }

    it { s.should be_occurs_on(Date.today + 1.year) }
    it { s.should_not be_occurs_on(Date.today + 1.year + 1.day) }
  end

  describe "do monthly" do
    let(:d) { Date.today }
    let(:s) { Schedule.new(kind: :monthly, monthly_day: d.day) }

    it "specific day" do 
      s.should be_occurs_on(d)
    end 
    it "specific day + 1 month" do 
      s.should be_occurs_on(d + 1.month)
    end 
    it "specific day + a month and a day" do 
      s.should_not be_occurs_on(d + 1.month + 1.day)
    end
  end

  describe "do 1st day of month" do
    let(:d) { Date.new((Date.today + 1.year).year, Date.today.month, 1) }
    let(:s) { Schedule.new(kind: :first_day_month) }

    it { s.should be_occurs_on(d) } 
    it { s.should_not be_occurs_on(d + 1.day) }
  end

  describe "do last day of month" do
    let(:d) { Date.new((Date.today + 1.year).year, Date.today.month, 1) - 1.day }
    let(:s) { Schedule.new(kind: :last_day_month) }

    it { s.should be_occurs_on(d) } 
    it { s.should_not be_occurs_on(d + 1.day) }
  end

  describe "for none" do
    let(:s) { Schedule.new(kind: :none) }

    # it { s.exists?.should be false } 
    it { s.should_not be_exists } 
  end
end