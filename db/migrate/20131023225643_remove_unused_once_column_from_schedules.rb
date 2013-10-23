class RemoveUnusedOnceColumnFromSchedules < ActiveRecord::Migration
  def up
    remove_column :schedules, :once_year
    remove_column :schedules, :once_month
    remove_column :schedules, :once_day
  end

  def down
    add_column :schedules, :once_day, :string
    add_column :schedules, :once_month, :string
    add_column :schedules, :once_year, :string
  end
end
