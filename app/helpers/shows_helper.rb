module ShowsHelper
  def progress(show, season=nil)
    unless season
      (current_user.episodes.find_all_by_show_id(show.id).reject{ |e| e.air_date ? e.air_date > Date.today : false }.size.to_f /
        show.episodes.reject{ |e| e.air_date ? e.air_date > Date.today : false }.size.to_f * 100).round
    else
      total_episodes = show.episodes.select{ |e| e.season == season }.size.to_f
      watched_episodes = current_user.episodes.find_all_by_show_id(show.id).select{ |e| e.season == season }.size.to_f
      (watched_episodes / total_episodes * 100).round
    end
  end
end
