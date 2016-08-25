class Activity < ApplicationRecord
  belongs_to :quest
  belongs_to :user

  validates :start_time, uniqueness: true
end
