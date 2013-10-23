class AddOnceDateToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :once_date, :date
  end
end
