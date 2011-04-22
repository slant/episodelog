class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => :index

  def index
    render :dashboard if user_signed_in?
    @shows = Show.all
  end

  def dashboard
    @shows = Show.all
  end
end
