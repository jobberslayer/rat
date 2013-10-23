class AddDefaultValueToScheduleType < ActiveRecord::Migration
  def change
    change_column :tasks, :schedule_type, :string, default: 'none', null: false
  end
end
