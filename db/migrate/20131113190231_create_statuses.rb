class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :title
      t.text :info
      t.integer :task_id

      t.timestamps
    end
  end
end
