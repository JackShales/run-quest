class UsersController < ApplicationController
  def show
    if current_user
      @auth = "#{ENV['HEALTH_GRAPH_AUTH_END_POINT']}?client_id=#{ENV['HEALTH_GRAPH_CLIENT_ID']}&response_type=code&redirect_uri=#{ENV['REDIRECT_URI']}"
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
    render 'authorize.html.erb'
    # @coffee = Unirest.post(
    #   "#{ENV['API_BASE_URL']}/coffee.json", 
    #   headers: {"Accept" => "application/json"}, 
    #   parameters: { 
    #     name: params[:name], 
    #     description: params[:description], 
    #     price: params[:price], 
    #     weight: params[:weight]
    #   }
    # ).body
  end
end
