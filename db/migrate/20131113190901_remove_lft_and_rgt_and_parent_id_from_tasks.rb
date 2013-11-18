class RemoveLftAndRgtAndParentIdFromTasks < ActiveRecord::Migration
  def up
    remove_column :tasks, :parent_id
    remove_column :tasks, :lft
    remove_column :tasks, :rgt
  end

  def down
  end
end
