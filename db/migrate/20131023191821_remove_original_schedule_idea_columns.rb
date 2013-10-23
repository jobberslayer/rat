class RemoveOriginalScheduleIdeaColumns < ActiveRecord::Migration
  def up
    remove_column :tasks, :schedule_type
    remove_column :tasks, :schedule_serialized
    remove_column :tasks, :schedule_data
  end

  def down
  end
end
