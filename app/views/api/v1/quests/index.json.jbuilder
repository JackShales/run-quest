json.array! @quests do |quest|
  json.id quest.id
  json.name quest.name
  json.statusCode quest.status_code
  json.questType quest.quest_type
  json.deadline quest.deadline
  json.notes quest.notes
  json.assignerId quest.assigner_id
  json.assigneeId quest.assignee_id
end
