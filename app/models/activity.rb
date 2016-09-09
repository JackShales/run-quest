class Activity < ApplicationRecord
  belongs_to :quest
  belongs_to :user
  has_many :datapoints

  validates :start_time, uniqueness: true

  def friendly_start_time
    start_time.strftime("%B %e, %Y, %l:%M %p")
  end

  def distance_in_miles
    (distance * 0.000621371).round(2)
  end

  def friendly_duration
    hours = (duration / 3600).to_i
    minutes = ((duration % 3600) / 60).to_i
    seconds = (duration - ((hours * 3600) + (minutes * 60))).to_i
    format("%02d:%02d:%02d", hours, minutes, seconds)
  end

  def avg_pace
    raw_minutes = duration / 60
    raw_pace = raw_minutes / distance_in_miles
    pace_minutes = raw_pace.to_i
    pace_seconds = (raw_pace - pace_minutes) * 60
    format("%02d:%02d", pace_minutes, pace_seconds)
  end

  def calc_xp
    cal_xp = calories / 5
    cal_xp
  end
end
