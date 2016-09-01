class QuestsController < ApplicationController
  def index
    my_quests = Quest.where(assignee_id: current_user.id)
    my_assigned_quests = Quest.where(assigner_id: current_user.id)
    @quest_inbox = my_quests.where(status_code: 0)
    @active_inbox = my_quests.where(status_code: 1)
    @declined_inbox = my_quests.where(status_code: 2)
    @cancelled_inbox = my_quests.where(status_code: 3)
    @complete_inbox = my_quests.where(status_code: 4)
    @quest_outbox = my_assigned_quests.where(status_code: 0)
    @active_outbox = my_assigned_quests.where(status_code: 1)
    @declined_outbox = my_assigned_quests.where(status_code: 2)
    @cancelled_outbox = my_assigned_quests.where(status_code: 3)
    @complete_outbox = my_assigned_quests.where(status_code: 4)
    render 'index.html.erb'
  end

  def create
    ddln_year = params[:deadline]["year"].to_i
    ddln_month = params[:deadline]["month"].to_i
    ddln_day = params[:deadline]["day"].to_i
    quest = Quest.new(
      quest_type: params[:quest_type],
      name: params[:name],
      notes: params[:goal],
      status_code: 0,
      deadline: Date.new(ddln_year, ddln_month, ddln_day),
      assigner_id: current_user.id,
      assignee_id: params[:assignee_id]
    )
    quest.save
    redirect_to "/quests/#{quest.id}"
  end

  def show
    @quest = Quest.find_by(id: params[:id])
    unassigned_activities = current_user.activities.where(quest_id: nil)
    @show_activities = unassigned_activities.select { |activity| activity.start_time > (@quest.deadline - 1.month) }
    @quest_activities = current_user.activities.where(quest_id: @quest.id)
    @assigner = User.find_by(id: @quest.assigner_id)
    @assignee = User.find_by(id: @quest.assignee_id)
    render 'show.html.erb'
  end

  def update
    quest = Quest.find_by(id: params[:id])
    quest.name = params[:quest_name] || quest.name
    quest.status_code = params[:choice].to_i || quest.status_code
    quest.quest_type = params[:quest_type] || quest.quest_type
    quest.deadline = params[:deadline] || quest.deadline
    quest.notes = params[:quest_notes] || quest.notes 
    quest.save
    giver = quest.assigner
    receiver = quest.assignee
    if params[:choice] && params[:choice].to_i == 4
      receiver.update(experience: receiver.experience + quest.calc_xp)
      giver.update(experience: giver.experience + 50)
    end

    level_bar = 0
    level_hash = {}
    (1..100).each do |level_number|
      level_hash.merge!(level_number => level_bar)
      level_bar += 250 * level_number
    end

    if receiver.level_up?
      receiver.update(level: receiver.level_change)
    end
    if giver.level_up?
      giver.update(level: giver.level_change)
    end
    redirect_to "/quests/#{quest.id}"
  end
end
