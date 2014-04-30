class RenameTableGroupsToPerms < ActiveRecord::Migration
  def up
    rename_table :groups, :perms
  end

  def down
    rename_table :perms, :groups
  end
end
