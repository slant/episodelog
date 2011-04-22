class HomeController < ApplicationController
  def index
    render :dashboard if user_signed_in?
    @shows = Show.all
  end

  def dashboard
    @shows = Show.all
  end
end
