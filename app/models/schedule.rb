require 'ice_cube'

class Schedule < ActiveRecord::Base
  attr_accessible :monthly_day, :once_date, :kind, :weekly_day, :yearly_date, :yearly_day, :yearly_month
  belongs_to :tasks

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

  def ic_once
    IceCube::Schedule.new(once_date) 
  end

  def add_rule(rule)
    ic = IceCube::Schedule.new
    ic.add_recurrence_rule rule
    ic
  end
end
