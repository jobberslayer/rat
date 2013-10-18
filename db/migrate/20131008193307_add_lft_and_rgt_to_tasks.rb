class AddLftAndRgtToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :lft, :integer
    add_column :tasks, :rgt, :integer
  end
end
