class ActivitiesController < ApplicationController
  def index
    hg_activities_raw = Unirest.get("http://api.runkeeper.com/fitnessActivities/?token_type=#{current_user.token_type}&access_token=#{current_user.access_token}").body
    @hg_total = hg_activities_raw["size"]
    @hg_activities = hg_activities_raw["items"]
    render 'index.html.erb'
  end
end
