class ApplicationController < ActionController::Base
  protect_from_forgery

  def update_show_state
    state = params[:state]
    puts params[:show_id]
    show = Show.find(params[:show_id])

    if state == 'add'
      unless current_user.shows.include? show
        current_user.shows << show
      end
    elsif state == 'remove'
      if current_user.shows.include? show
        current_user.shows.delete show
      end
    end

    render :nothing => true
  end

  def update_episode_state
    state = params[:state]
    episode = Episode.find(params[:episode_id])

    if state == 'add'
      unless current_user.episodes.include? episode
        current_user.episodes << episode
      end
    elsif state == 'remove'
      if current_user.episodes.include? episode
        current_user.episodes.delete episode
      end
    end

    render :nothing => true
  end
end
