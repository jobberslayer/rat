class AddTaskIdToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :task_id, :integer
  end
end
