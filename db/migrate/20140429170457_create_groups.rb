class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :user_id
      t.string :object
      t.integer :obj_id
      t.string :mode

      t.timestamps
    end
  end
end
