class QuestsController < ApplicationController
  def index
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
    render 'show.html.erb'
  end
end
