class AddScheduleTypeAndDataToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :schedule_type, :string
    add_column :tasks, :schedule_data, :text
  end
end
