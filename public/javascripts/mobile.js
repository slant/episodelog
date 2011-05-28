$(function(){
  $('.search_button').bind('click', function(){
    if ($('#search_box').is(':visible')){
      // TODO: We will eventually want this to simply slide back up if
      // no search is in progress, not reload the page
      $('#search_box').slideUp('fast');
      if ($('#query').value('')) { return false; }
    } else {
      $('#search_box').slideDown('fast');
      return false;
    }
  });

  $('.episode .status').bind('click', function(){
    episode = $(this).closest('.episode');
    episode_id = $(this).closest('.episode').attr('id').split('_')[1];

    if (episode.hasClass('watched')){
      toggle_episode(episode_id, 'remove');
      episode.removeClass('watched');
      episode.find('.status a').text('-');
    } else {
      toggle_episode(episode_id, 'add');
      episode.addClass('watched');
      episode.find('.status a').text('watched');
    }
    return false;
  });
});

function toggle_episode(episode_id, episode_state) {
  $.get('/update_episode_state', { episode_id: episode_id, state: episode_state });
}