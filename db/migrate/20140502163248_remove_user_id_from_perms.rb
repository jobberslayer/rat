class RemoveUserIdFromPerms < ActiveRecord::Migration
  def up
    remove_column :perms, :user_id
  end

  def down
    add_column :perms, :user_id, :integer
  end
end
