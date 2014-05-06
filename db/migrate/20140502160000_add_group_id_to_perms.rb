class AddGroupIdToPerms < ActiveRecord::Migration
  def change
    add_column :perms, :group_id, :integer
  end
end
