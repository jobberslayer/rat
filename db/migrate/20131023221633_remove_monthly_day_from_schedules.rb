class RemoveMonthlyDayFromSchedules < ActiveRecord::Migration
  def up
    remove_column :schedules, :monthly_day
  end

  def down
    add_column :schedules, :monthly_day, :string
  end
end
