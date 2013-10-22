class RenameScheduleIcalToScheduleSerializeInTasks < ActiveRecord::Migration
  def up
    rename_column :tasks, :schedule_ical, :schedule_serialized
  end

  def down
    rename_column :tasks, :schedule_serialized, :schedule_ical
  end
end
