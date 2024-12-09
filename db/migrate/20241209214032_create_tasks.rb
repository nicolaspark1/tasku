class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :category_id
      t.float :fee
      t.time :deadline
      t.string :location
      t.integer :requester_id
      t.string :status
      t.date :accepted_at
      t.date :completed_at
      t.integer :tasker_id
      t.integer :reviews_count

      t.timestamps
    end
  end
end
