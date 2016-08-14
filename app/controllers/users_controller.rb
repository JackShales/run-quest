class UsersController < ApplicationController
  def home
    if current_user
      @auth = "#{ENV['HEALTH_GRAPH_AUTH_END_POINT']}?client_id=#{ENV['HEALTH_GRAPH_CLIENT_ID']}&response_type=code&redirect_uri=#{ENV['REDIRECT_URI']}"
      render 'home.html.erb'
    else
      redirect_to '/login'
    end
  end

  def index
    @users = User.all
  end

  def show 
    @user = User.find_by(id: params[:id])
    render 'show.html.erb'
  end

  def new
    render 'new.html.erb'
  end

  def create
    user = User.new(
      char_name: params[:character_name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      experience: 0,
      speed: 1,
      endurance: 1,
      mental: 1,
      level: 1
    )
    if user.save
      session[:user_id] = user.id
      flash[:success] = 'Character Created'
      redirect_to '/'
    else
      flash[:warning] = 'Invalid email or password!'
      redirect_to '/signup'
    end
  end

  def authorize
    @code = params[:code]
    @post = Unirest.post(
      "#{ENV['HEALTH_GRAPH_ACCESS_TOKEN_END_POINT']}",
      headers: {"Accept" => "application/json"},
      parameters: {
        grant_type: "authorization_code",
        code: @code,
        client_id: "#{ENV['HEALTH_GRAPH_CLIENT_ID']}",
        client_secret: "#{ENV['HEALTH_GRAPH_CLIENT_SECRET']}",
        redirect_uri: "#{ENV['REDIRECT_URI']}"
      }
    ).body
    current_user.update(access_token: @post["access_token"], token_type: @post["token_type"])
    hg_activities_raw = Unirest.get("http://api.runkeeper.com/fitnessActivities/?token_type=#{current_user.token_type}&access_token=#{current_user.access_token}").body
    hg_activities = hg_activities_raw["items"]

    quest = Quest.create(
      name: "Runkeeper Upload",
      status: "complete",
      quest_type: "self",
      assigner_id: current_user.id,
      assignee_id: current_user.id
    )

    hg_activities.each do |activity|
      Activity.create(
        start_time: activity["start_time"],
        distance: activity["total_distance"],
        duration: activity["duration"],
        calories: activity["total_calories"],
        quest_id: quest.id,
        user_id: current_user.id
      )
    end
    flash[:success] = 'Successfully linked RunKeeper Account!'
    redirect_to '/activities'
  end
end
