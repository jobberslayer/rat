require 'ice_cube'

class Schedule < ActiveRecord::Base
  attr_accessible :monthly_day, :once_date, :kind, :weekly_day, :yearly_date, :yearly_day, :yearly_month
  belongs_to :tasks

  def occurs_on?(date)
    ice_cube.occurs_on?(date)
  end

  def exists?
    not ice_cube.nil?
  end

  def to_s
    exists? ? ice_cube.to_s : 'none'
  end

  def ice_cube
    send("ic_#{kind}")
  end

  def ic_none
    nil
  end
  
  def ic_yearly
    add_rule(IceCube::Rule.yearly.month_of_year(yearly_date.month).day_of_month(yearly_date.day))
  end

  def ic_monthly
    add_rule(IceCube::Rule.monthly.day_of_month(monthly_day))
  end

  def ic_first_day_month
    add_rule(IceCube::Rule.monthly.day_of_month(1))
  end

  def ic_last_day_month
    add_rule(IceCube::Rule.monthly.day_of_month(-1))
  end

  def ic_once
    IceCube::Schedule.new(once_date) 
  end

  def add_rule(rule)
    ic = IceCube::Schedule.new
    ic.add_recurrence_rule rule
    ic
  end
end
