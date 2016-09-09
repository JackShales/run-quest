json.id @activity.id
json.questId @activity.quest_id
json.userId @activity.user_id
json.calories @activity.calories
json.duration @activity.friendly_duration
json.distance @activity.distance_in_miles
json.avgPace @activity.avg_pace
json.startTime @activity.friendly_start_time
json.uri @activity.uri
json.dataPoints @activity.datapoints do |datapoint|
    json.id datapoint.id
    json.latitude datapoint.latitude
    json.longitude datapoint.longitude
  end
