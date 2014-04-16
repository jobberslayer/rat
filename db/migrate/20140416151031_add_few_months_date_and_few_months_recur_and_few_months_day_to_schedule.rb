class AddFewMonthsDateAndFewMonthsRecurAndFewMonthsDayToSchedule < ActiveRecord::Migration
  def change
    add_column :schedules, :few_months_date, :date
    add_column :schedules, :few_months_recur, :integer
    add_column :schedules, :few_months_day, :integer
  end
end
