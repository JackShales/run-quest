class ActivitiesController < ApplicationController
  def index
    @activities = current_user.activities
    render 'index.html.erb'
  end
end
