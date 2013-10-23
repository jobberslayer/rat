class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :type, null: false
      t.integer :yearly_month
      t.integer :yearly_day
      t.integer :monthly_day
      t.integer :weekly_day
      t.integer :once_year
      t.integer :once_month
      t.integer :once_day

      t.timestamps
    end
  end
end
