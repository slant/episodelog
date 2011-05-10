class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :prepare_for_iphone

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

  def prepare_for_iphone
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
  end

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == '1'
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  helper_method :mobile_device?
end
