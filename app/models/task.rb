# == Schema Information
#
# Table name: tasks
#
#  id            :bigint           not null, primary key
#  accepted_at   :date
#  completed_at  :date
#  deadline      :time
#  description   :text
#  fee           :float
#  location      :string
#  reviews_count :integer
#  status        :string
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  category_id   :integer
#  requester_id  :integer
#  tasker_id     :integer
#
class Task < ApplicationRecord
  belongs_to :requester, required: true, class_name: "User", foreign_key: "requester_id", counter_cache: true

  belongs_to :tasker, optional: true, class_name: "User", foreign_key: "tasker_id", counter_cache: :assignments_count

  has_many  :reviews, class_name: "Review", foreign_key: "task_id", dependent: :destroy

  belongs_to :category, required: true, class_name: "TaskCategory", foreign_key: "category_id", counter_cache: true
end
