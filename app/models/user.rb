class User < ApplicationRecord
  has_secure_password

  has_many :quests, through: :user_quests
  belongs_to :clan
  has_many :assigners, through: :quests, source: :assigner
  has_many :assignees, through: :quests, source: :assignee
end
