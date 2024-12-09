# == Schema Information
#
# Table name: task_categories
#
#  id          :bigint           not null, primary key
#  desc        :text
#  name        :string
#  tasks_count :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class TaskCategory < ApplicationRecord
  has_many  :tasks, class_name: "Task", foreign_key: "category_id", dependent: :destroy
end
