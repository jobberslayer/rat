class RemoveYearlyMonthYearlyDayFromSchedules < ActiveRecord::Migration
  def up
    remove_column :schedules, :yearly_day
    remove_column :schedules, :yearly_month
  end

  def down
  end
end
