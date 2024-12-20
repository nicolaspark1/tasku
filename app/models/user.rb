# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  assignments_count      :integer
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  reviews_count          :integer
#  role                   :string
#  tasks_count            :integer
#  university             :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  def admin?
    role == "admin"
  end

  def regular_user?
    role == "user"
  end
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many  :tasks, class_name: "Task", foreign_key: "requester_id", dependent: :destroy

  has_many  :reviews, class_name: "Review", foreign_key: "reviewer_id", dependent: :destroy
  
  has_many  :assignments, class_name: "Task", foreign_key: "tasker_id", dependent: :nullify

end
