class Quest < ApplicationRecord
  has_many :activities
  belongs_to :assigner, class_name: :User, foreign_key: :assigner_id
  belongs_to :assignee, class_name: :User, foreign_key: :assignee_id
  has_many :user_quests
  has_many :users, through: :user_quests

  def assignee
    assignee = User.find_by(id: assignee_id)
    assignee
  end

  def assigner
    assigner = User.find_by(id: assigner_id)
    assigner
  end

  def status
    statuses = ["awaiting response", "active", "declined", "cancelled", "complete"]
    statuses[status_code]
  end
end
