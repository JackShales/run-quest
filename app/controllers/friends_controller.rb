class FriendsController < ApplicationController
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
      flash = "Request sent"
    else
      puts friendship.errors.full_messages
    end
    redirect_to "/"
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
    redirect_to "/"
  end
end
