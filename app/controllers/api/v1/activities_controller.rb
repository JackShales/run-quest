class Api::V1::ActivitiesController < ApplicationController
  def index
    @activities = Activity.all
    render 'index.json.jbuilder'
  end

  def show
    @activity = Activity.find_by(id: params[:id])
    render 'show.json.jbuilder'
  end
end
