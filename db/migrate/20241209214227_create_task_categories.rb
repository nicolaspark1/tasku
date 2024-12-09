class CreateTaskCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :task_categories do |t|
      t.string :name
      t.text :desc
      t.integer :tasks_count

      t.timestamps
    end
  end
end
