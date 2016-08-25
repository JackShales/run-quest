json.array! @activities do |activity|
  json.id activity.id
  json.questId activity.quest_id
  json.userId activity.user_id
  json.calories activity.calories
  json.duration activity.duration
  json.distance activity.distance
  json.startTime activity.friendly_start_time
end