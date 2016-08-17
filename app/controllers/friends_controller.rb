class FriendsController < ApplicationController
  def create
    friend = Friendship.new(
      user_id: current_user.id,
      friend_id: params[:friend_id],
      status_code: 0
    )
    friend.save
    flash = "Request sent"
    redirect_to "/"
  end
end
