class Activity < ApplicationRecord
  belongs_to :quest
  belongs_to :user

  validates :start_time, uniqueness: true

  def friendly_start_time
    start_time.strftime("%B %e %Y, %l:%M %p")
  end

  def distance_in_miles
    distance * 0.000621371
  end

  def friendly_duration
  end
end
