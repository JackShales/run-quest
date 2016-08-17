class FriendsController < ApplicationController
  def create
    friendship = Friendship.new(
      user_id: current_user.id,
      friend_id: params[:friend_id],
      status_code: 0
    )
    friend.save
    flash = "Request sent"
    redirect_to "/"
  end

  def update
    friendship = Friendship.find_by(user_id: params[:id], friend_id: current_user.id)
    friendship.update(status_code: params[:choice])
    redirect_to "/"
  end
end
