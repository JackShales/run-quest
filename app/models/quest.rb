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
    statuses = ["pending", "active", "declined", "cancelled", "complete"]
    statuses[status_code]
  end

  def calc_xp
    base_xp = 50
    cal_xp = 0
    activities.each do |activity|
      cal_xp = cal_xp + (activity.calories / 5)
    end
    total_xp = cal_xp + base_xp
    total_xp
  end

  def creation_month
    created_at.strftime("%b '%y")
  end

  def creation_day
    created_at.strftime("%e")
  end
end
