class RemoveStatusIdFromStatuses < ActiveRecord::Migration
  def up
    remove_column :statuses, :status_id
  end

  def down
    add_column :statuses, :status_id, :integer
  end
end
