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
    @assigner = User.find_by(id: @quest.assigner_id)
    @assignee = User.find_by(id: @quest.assignee_id)
    render 'show.html.erb'
  end

  def update
    quest = Quest.find_by(id: params[:id])
    quest.update(status_code: params[:choice].to_i || quest.status_code)
    redirect_to "/quests/#{quest.id}"
  end
end
