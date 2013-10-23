class AddYearlyDateToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :yearly_date, :date
  end
end
