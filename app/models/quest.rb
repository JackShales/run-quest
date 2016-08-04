class Quest < ApplicationRecord
  has_many :activities
  has_many :users, through: :user_quests
  has_many :clans, through: :clan_quests
  belongs_to :assigner, class_name: :User, foreign_key: :assigner_id
  belongs_to :assignee, class_name: :User, foreign_key: :assignee_id
end
