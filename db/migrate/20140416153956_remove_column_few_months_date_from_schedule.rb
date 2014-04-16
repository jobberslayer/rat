class RemoveColumnFewMonthsDateFromSchedule < ActiveRecord::Migration
  def up
    remove_column :schedules, :few_months_date
  end

  def down
    add_column :schedules, :few_months_date, :date
  end
end
