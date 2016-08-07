class Activity < ApplicationRecord
  belongs_to :quest

  def friendly_pace
    minutes = avg_pace.to_i
    uf_seconds = avg_pace - minutes
    f_seconds = (uf_seconds * 60).to_i
    "#{minutes}:#{f_seconds}/mi"
  end
end
