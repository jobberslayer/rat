class AddCertainDaysToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :certain_monday, :boolean
    add_column :schedules, :certain_tuesday, :boolean
    add_column :schedules, :certain_wednesday, :boolean
    add_column :schedules, :certain_thursday, :boolean
    add_column :schedules, :certain_friday, :boolean
    add_column :schedules, :certain_saturday, :boolean
    add_column :schedules, :certain_sunday, :boolean
  end
end
