class RenameTypeToKindInSchedules < ActiveRecord::Migration
  def up
    rename_column :schedules, :type, :kind
  end

  def down
  end
end
