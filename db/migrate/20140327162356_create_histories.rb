class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.integer :schedule_id
      t.datetime :completed_for

      t.timestamps
    end
  end
end
