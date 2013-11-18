class AddStatusIdToStatus < ActiveRecord::Migration
  def change
    add_column :statuses, :status_id, :integer
  end
end
