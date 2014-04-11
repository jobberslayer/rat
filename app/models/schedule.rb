require 'ice_cube'

class Schedule < ActiveRecord::Base
  attr_accessible :monthly_day, :once_date, :kind, :weekly_day, :yearly_date, :yearly_day, :yearly_month, 
    :weekly_date, :weekly_interval

  belongs_to :tasks
  belongs_to :statuses

  has_many :histories, dependent: :destroy

  def occurs_on?(date)
    if ice_cube.nil?
      return false
    else
      ice_cube.occurs_on?(date)
    end
  end

  def next_occurrence
    if ice_cube.nil?
      nil
    else
      today = Time.current
      if ice_cube.occurs_on?(today)
        return today
      else
        return ice_cube.next_occurrence()
      end
    end
  end

  def occurs_between(d1, d2)
    if ice_cube.nil?
      []
    else
      ice_cube.occurrences_between(d1, d2)
    end
  end

  def exists?
    not ice_cube.nil?
  end

  def history_on(d)
    if histories.exists?
      histories.where("completed_for >= ? and completed_for <= ?", d.strftime("%Y-%m-%d 00:00:00"), d.strftime("%Y-%m-%d 23:59:59")).first
    else
      return nil
    end
  end

  def log_date(d)
    h = history_on(d)
    if h.nil?
      h = History.new
      h.schedule_id = id
      h.completed_for = d 
      h.save
    else
      h.completed_for = d
      h.save
    end
  end

  def log_next()
    log_date(next_occurrence())
  end

  def unlog_date(d)
    h = history_on(d)
    if h.nil?
    else
      h.destroy
    end
  end

  def unlog_next
    unlog_date(next_occurrence())
  end

  def all_overdue(end_date = Date.today)
    overdue = []

    occurs_between(updated_at.to_date, end_date).each do |d|
      h = history_on(d)  
      if h.nil?
        overdue.push(d)
      end
    end

    return overdue
  end

  def to_s
    case 
    when !exists?
      'none'
    when kind == 'weekly'
      ice_cube.to_s + " starting on #{weekly_date.strftime('%A, %B %d, %Y')}"
    else
      ice_cube.to_s
    end
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
    IceCube::Schedule.new(Time.utc(once_date.year, once_date.month, once_date.day, 23, 59, 59))
  end

  def ic_weekly
    s = IceCube::Schedule.new(weekly_date)
    s.add_recurrence_rule IceCube::Rule.weekly(weekly_interval)
    s
  end

  def add_rule(rule)
    ic = IceCube::Schedule.new
    ic.add_recurrence_rule rule
    ic
  end
end
