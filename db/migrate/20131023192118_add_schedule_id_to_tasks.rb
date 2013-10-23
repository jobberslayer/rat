class AddScheduleIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :schedule_id, :integer
  end
end
