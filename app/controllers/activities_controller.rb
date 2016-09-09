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
    @url = "https://maps.googleapis.com/maps/api/js?key=#{ENV['GOOGLE_MAP_KEY']}&callback=initMap&libraries=geometry"
    render 'new.html.erb'
  end

  def create_manual
    distance_miles = (params[:distance].to_f * 0.000621371).round(2)
    calories = distance_miles * (0.75 * params[:activity][:weight].to_f)
    duration = ((params[:activity][:end_time].to_datetime - params[:activity][:start_time].to_datetime) * 24 * 60 * 60).to_i
    activity = Activity.new(
      distance: params[:distance],
      calories: calories.to_i,
      start_time: params[:activity][:start_time].to_datetime,
      duration: duration,
      user_id: current_user.id
    )
    if activity.save
      # datapoints_string = params[:data_points].tr!('"', '')
      @data_points = eval(params[:data_points])
      @data_points.each do |datapoint|
        Datapoint.create(
          activity_id: activity.id,
          latitude: datapoint[:lat],
          longitude: datapoint[:lng]
        )
      end
      flash[:success] = "Activity created"
      redirect_to "/activities/#{activity.id}"
    else
      flash[:danger] = "Error in saving activity"
      redirect_to "/activities/new"
    end
  end
end
