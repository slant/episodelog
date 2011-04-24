class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => :index

  def index
    redirect_to dashboard_url if user_signed_in?
    @shows = Show.all
  end

  def dashboard
    @shows = current_user.shows
  end
end
