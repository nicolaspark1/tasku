class ChangeDeadlineToDateTimeInTasks < ActiveRecord::Migration[7.1]
  def change
    remove_column :tasks, :deadline
    add_column :tasks, :deadline, :datetime
  end
end
