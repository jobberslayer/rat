class AddStatusIdToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :status_id, :integer
  end
end
