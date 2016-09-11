class FriendsController < ApplicationController
  def index

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

    render 'index.html.erb'
  end

  def create
    id_1 = current_user.id
    id_2 = params[:friend_id].to_i

    if id_1 > id_2
      id_1 = id_2
      id_2 = current_user.id
    end

    friendship = Friendship.new(
      user_id: id_1,
      friend_id: id_2,
      status_code: 0,
      action_user_id: current_user.id
    )
    if friendship.save
      flash[:success] = "Request sent"
    else
      puts friendship.errors.full_messages
    end
    redirect_to "/users"
  end

  def update
    id_1 = current_user.id
    id_2 = params[:id].to_i

    if id_1 > id_2
      id_1 = id_2
      id_2 = current_user.id
    end
    friendship = Friendship.find_by(user_id: id_1, friend_id: id_2)
    friendship.update(status_code: params[:choice])
    if friendship.status_code == 1
      flash[:success] = "Friend added"
    else
      flash[:danger] = "Friend declined..."
    end
    redirect_to "/friends"
  end
end
