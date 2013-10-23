class Schedule < ActiveRecord::Base
  attr_accessible :monthly_day, :once_date, :kind, :weekly_day, :yearly_date, :yearly_day, :yearly_month
  belongs_to :tasks
end
