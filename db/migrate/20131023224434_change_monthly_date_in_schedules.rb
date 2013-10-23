class ChangeMonthlyDateInSchedules < ActiveRecord::Migration
  def up
    rename_column :schedules, :monthly_date, :monthly_day
    change_column :schedules, :monthly_day, :integer
  end

  def down
  end
end
