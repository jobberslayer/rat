class SetKindToNoneByDefaultInSchedule < ActiveRecord::Migration
  def up
    change_column :schedules, :kind, :string, null: :false, default: 'none'
  end

  def down
  end
end
