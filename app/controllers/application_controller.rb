class ApplicationController < ActionController::Base
  protect_from_forgery

  def update_show_state
    state = params[:state]
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
    
  end
end
