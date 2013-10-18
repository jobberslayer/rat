class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :company_id
      t.text :info
      t.text :schedule
      t.integer :parent_id

      t.timestamps
    end
  end
end
