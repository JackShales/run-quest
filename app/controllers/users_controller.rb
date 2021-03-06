class UsersController < ApplicationController
  def home
    if current_user
      @auth = "#{ENV['HEALTH_GRAPH_AUTH_END_POINT']}?client_id=#{ENV['HEALTH_GRAPH_CLIENT_ID']}&response_type=code&redirect_uri=#{ENV['REDIRECT_URI']}"

      @activities = current_user.activities.order(start_time: :desc)

      @active_quests_num = Quest.where(assignee_id: current_user.id, status_code: 1).length
      @completed_quests_num = Quest.where(assignee_id: current_user.id, status_code: 4).length
      @total_activities_num = current_user.activities.length
      @quest_inbox = Quest.where(assignee_id: current_user.id, status_code: 0)
      @active_quests = Quest.where(assignee_id: current_user.id, status_code: 1)
      @active_assigned = Quest.where(assigner_id: current_user.id, status_code: 1)

      pending_friendships_1 = current_user.friendships.where(status_code: 0)
      pending_friendships_2 = current_user.inverse_friendships.where(status_code: 0)
      pending_friendships_all = pending_friendships_1 + pending_friendships_2
      @pending_friends_sent = []
      @pending_friends_received = []
      pending_friendships_all.each do |friendship|
        if friendship.action_user_id == current_user.id && friendship.user_id == current_user.id
          friend = User.find_by(id: friendship.friend_id)
          @pending_friends_sent << friend
        elsif friendship.action_user_id == current_user.id && friendship.friend_id == current_user.id
          friend = User.find_by(id: friendship.user_id)
          @pending_friends_sent << friend
        elsif friendship.action_user_id != current_user.id && friendship.user_id == current_user.id
          friend = User.find_by(id: friendship.friend_id)
          @pending_friends_received << friend
        else
          friend = User.find_by(id: friendship.user_id)
          @pending_friends_received << friend
        end
      end

      accepted_friendships_1 = current_user.friendships.where(status_code: 1)
      accepted_friendships_2 = current_user.inverse_friendships.where(status_code: 1)
      total_accepted_friendships = accepted_friendships_1 + accepted_friendships_2
      @accepted_friends = []
      total_accepted_friendships.each do |friendship|
        if friendship.friend_id == current_user.id
          function_id = friendship.user_id
        else
          function_id = friendship.friend_id
        end
        friend = User.find_by(id: function_id)
        @accepted_friends << friend
      end
      render 'home.html.erb'
    else
      redirect_to '/login'
    end
  end

  def index
    @users = []
    users = User.all.order(:char_name)
    users.each do |user|
      if user.id != current_user.id && !current_user.friend?(user)
        @users << user
      end
    end
    render 'index.html.erb'
  end

  def show 
    @user = User.find_by(id: params[:id])
    @active_quests_num = Quest.where(assignee_id: @user.id, status_code: 1).length
    @completed_quests_num = Quest.where(assignee_id: @user.id, status_code: 4).length
    @completed_quests = Quest.where(assignee_id: @user.id, status_code: 4)
    @active_quests = Quest.where(assignee_id: @user.id, status_code: 1)
    @total_activities_num = @user.activities.length
    @activities = @user.activities.order(start_time: :desc)

    accepted_friendships_1 = @user.friendships.where(status_code: 1)
    accepted_friendships_2 = @user.inverse_friendships.where(status_code: 1)
    total_accepted_friendships = accepted_friendships_1 + accepted_friendships_2
    @accepted_friends = []
    total_accepted_friendships.each do |friendship|
      if friendship.friend_id == @user.id
        function_id = friendship.user_id
      else
        function_id = friendship.friend_id
      end
      friend = User.find_by(id: function_id)
      @accepted_friends << friend
    end

    render 'show.html.erb'
  end

  def new
    @user = User.new
    render 'new.html.erb'
  end

  def create
    @user = User.new(
      char_name: params[:character_name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      bio: params[:character_bio],
      avatar: params[:avatar],
      experience: 0,
      speed: 1,
      endurance: 1,
      mental: 1,
      level: 1
    )
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'Character Created'
      redirect_to '/'
    else
      flash[:danger] = 'Character Name or E-Mail already in use!'
      render 'new.html.erb'
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
    hg_activities_raw = Unirest.get("http://api.runkeeper.com/fitnessActivities/?page=0&pageSize=1000&token_type=#{current_user.token_type}&access_token=#{current_user.access_token}").body
    hg_activities = hg_activities_raw["items"]

    quest = Quest.create(
      name: "Runkeeper Upload",
      status_code: 4,
      quest_type: "Runkeeper",
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
        uri: activity["uri"],
        user_id: current_user.id
      )

      current_user.update(experience: current_user.experience + (activity["total_calories"] / 5))
      if current_user.level_up?
        current_user.update(level: current_user.level_change)
      end
    end
    flash[:success] = 'Successfully linked RunKeeper Account!'
    redirect_to '/activities'
  end
end
