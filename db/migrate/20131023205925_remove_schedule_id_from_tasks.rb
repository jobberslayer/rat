class RemoveScheduleIdFromTasks < ActiveRecord::Migration
  def up
    remove_column :tasks, :schedule_id
  end

  def down
  end
end
