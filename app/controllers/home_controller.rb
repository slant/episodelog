class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => :index

  def index
    redirect_to dashboard_url if user_signed_in?
    @shows = Show.all
  end

  def dashboard
    @shows = current_user.shows.order('name asc')

    # Get all shows user has watched to any extent
    @watched_shows = Show.find(current_user.episodes.collect(&:show_id).uniq)

    # Find shows completed by user
    @completed_shows = []
    @watched_shows.each do |show|
      if show.episodes.reject{ |e| e.air_date ? e.air_date > Date.today : false }.size == current_user.episodes.where( :show_id => show.id ).reject{ |e| e.air_date ? e.air_date > Date.today : false }.size
        @completed_shows << show
      end
    end

    @shows.reject! { |s| @completed_shows.include? s }
    @watched_shows.reject! { |s| @shows.include?(s) or @completed_shows.include?(s) }
  
    @show_count = @shows.size + @watched_shows.size + @completed_shows.size
  end
end
