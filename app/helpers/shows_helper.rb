module ShowsHelper
  def progress(show)
    (current_user.episodes.find_all_by_show_id(show.id).size.to_f / show.episodes.size.to_f * 100).round
  end
end
