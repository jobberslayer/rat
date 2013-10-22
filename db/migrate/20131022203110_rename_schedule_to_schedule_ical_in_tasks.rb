class RenameScheduleToScheduleIcalInTasks < ActiveRecord::Migration
  def up
    rename_column :tasks, :schedule, :schedule_ical
  end

  def down
    rename_column :tasks, :schedule_ical, :schedule
  end
end
