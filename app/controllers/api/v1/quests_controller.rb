class Api::V1::QuestsController < ApplicationController
  def index
    @quests = Quest.all
    render 'index.json.jbuilder'
  end

  def show
    @quest = Quest.find_by(id: params[:id])
    render 'show.json.jbuilder'
  end
end
