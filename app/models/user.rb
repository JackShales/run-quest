class User < ApplicationRecord
  has_secure_password
  
  has_many :activities
  has_many :user_quests
  has_many :quests, through: :user_quests
  has_many :assigners, through: :quests, source: :assigner
  has_many :assignees, through: :quests, source: :assignee
end
