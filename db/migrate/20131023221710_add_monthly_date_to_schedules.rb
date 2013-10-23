class AddMonthlyDateToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :monthly_date, :date
  end
end
