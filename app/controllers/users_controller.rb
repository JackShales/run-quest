class UsersController < ApplicationController
  def show
    if current_user
      render 'show.html.erb'
    else
      redirect_to '/login'
    end
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
      speed: 0,
      endurance: 0,
      mental: 0,
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
end
