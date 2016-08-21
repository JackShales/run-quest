class ActivitiesController < ApplicationController
  def index
    @activities = current_user.activities
    render 'index.html.erb'
  end

  def show
  end

  def update
  end

  def new
  end
end
