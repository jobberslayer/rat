class AddWeeklyDateAndWeeklyIntervalToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :weekly_date, :date
    add_column :schedules, :weekly_interval, :integer
  end
end
