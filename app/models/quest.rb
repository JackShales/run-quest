class Quest < ApplicationRecord
  has_many :activities
  belongs_to :assigner, class_name: :User, foreign_key: :assigner_id
  belongs_to :assignee, class_name: :User, foreign_key: :assignee_id
  has_many :user_quests
  has_many :users, through: :user_quests
end
