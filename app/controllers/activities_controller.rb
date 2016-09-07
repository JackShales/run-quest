class ActivitiesController < ApplicationController
  def index
    @activities = current_user.activities.order(start_time: :desc)
    render 'index.html.erb'
  end

  def create
    hg_activities_raw = Unirest.get("http://api.runkeeper.com/fitnessActivities/?page=0&pageSize=1000&token_type=#{current_user.token_type}&access_token=#{current_user.access_token}").body
    hg_activities = hg_activities_raw["items"]

    hg_activities.each do |activity|
      Activity.create(
        start_time: activity["start_time"],
        distance: activity["total_distance"],
        duration: activity["duration"],
        calories: activity["total_calories"],
        uri: activity["uri"],
        user_id: current_user.id
      )
    end
    flash[:success] = "Activities successfully added!"
    redirect_to "/activities"
  end

  def show
    @activity = Activity.find_by(id: params[:id])
    @url = "https://maps.googleapis.com/maps/api/js?key=#{ENV['GOOGLE_MAP_KEY']}&callback=initMap"
    @auth = "#{ENV['HEALTH_GRAPH_AUTH_END_POINT']}?client_id=#{ENV['HEALTH_GRAPH_CLIENT_ID']}&response_type=code&redirect_uri=#{ENV['REDIRECT_URI']}"
    render 'show.html.erb'
  end

  def update
    activity = Activity.find_by(id: params[:id])
    activity.quest_id = params[:quest_id] || activity.quest_id
    activity.save
    redirect_to "/quests/#{activity.quest_id}"
  end

  def new
  end
end
