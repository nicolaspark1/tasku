# == Schema Information
#
# Table name: reviews
#
#  id          :bigint           not null, primary key
#  comment     :text
#  rating      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  reviewer_id :integer
#  task_id     :integer
#
class Review < ApplicationRecord
 
  belongs_to :reviewer, required: true, class_name: "User", foreign_key: "reviewer_id", counter_cache: true

  belongs_to :task, required: true, class_name: "Task", foreign_key: "task_id", counter_cache: true
end
