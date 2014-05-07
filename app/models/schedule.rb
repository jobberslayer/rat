require 'ice_cube'

class Schedule < ActiveRecord::Base
  attr_accessible :monthly_day, :once_date, :kind, :weekly_day, :yearly_date, :yearly_day, :yearly_month, 
    :weekly_date, :weekly_interval, :few_months_date, :few_months_recur, :few_months_day

  validates :monthly_day, numericality: { only_integer: true, :allow_blank => true }
  validates :weekly_interval, numericality: { only_integer: true, :allow_blank => true }
  validates :few_months_recur, numericality: { only_integer: true, :allow_blank => true }
  validate :needed_values_are_here

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
    return nil if d.nil?
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
    d = next_occurrence()
    log_date( d.strftime("%Y-%m-%d 00:00:00").to_date )
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
    s = IceCube::Schedule.new(Time.utc(weekly_date.year, weekly_date.month, weekly_date.day, 23, 59, 59))
    s.add_recurrence_rule IceCube::Rule.weekly(weekly_interval)
    s
  end

  def ic_daily
    add_rule(IceCube::Rule.daily)
  end

  def ic_daily_work
    add_rule(IceCube::Rule.daily.day(:monday, :tuesday, :wednesday, :thursday, :friday))
  end

  def ic_few_months
    add_rule( IceCube::Rule.monthly(few_months_recur).day_of_month(few_months_day) )
  end

  def add_rule(rule)
    ic = IceCube::Schedule.new(updated_at)
    ic.add_recurrence_rule rule
    ic
  end

  def needed_values_are_here 
    if kind == 'few_months'
      if few_months_recur.nil? 
        errors.add(:few_months_recur, "Recurring can't be blank")
      end

      if few_months_day.nil? 
        errors.add(:few_months_day, "Day can't be blank")
      end
    end

    if kind == 'once'
      if once_date.nil?
        errors.add(:once_date, "Date can't be blank")
      end
    end

    if kind == 'monthly'
      if monthly_day.nil?
        errors.add(:monthly_day, "Date can't be blank")
      end
    end

    if kind == 'yearly'
      if yearly_date.nil?
        errors.add(:yearly_date, "Date can't be blank")
      end
    end

    if kind == 'weekly'
      if weekly_date.nil?
        errors.add(:weekly_date, "Date can't be blank")
      end

      if weekly_interval.nil?
        errors.add(:weekly_interval, "Interval can't be blank")
      end
    end
  end
end
