$(document).ready(function(){
  initialize_seasons();

  // Follow show
  $('.show .add').bind('click', function(){
    show_id = $(this).closest('.show').attr('id').split('_')[1];
    show = $(this).closest('.show');

    $.ajax({
      method: 'get',
      url: '/update_show_state',
      data: { state: 'add', show_id: show_id },
      success: function(data) {
        $('.notice').text('This show has been added to your dashboard.').fadeIn();
        show.addClass('favorite');
        // $(this).removeClass('add').addClass('remove');
        // $(this).text('remove');
      },
      error: function(data) {
        $('.notice').text('There was a problem while trying to remove this show from your dashboard.').fadeIn();
      }
    });

    return false;
  });


  // Unfollow show
  $('.show .remove').bind('click', function(){
    show_id = $(this).closest('.show').attr('id').split('_')[1];
    show = $(this).closest('.show')
    if (confirm('Are you sure you want to stop following this show? All of your watched episodes will be forgotten.')){
      $.ajax({
        method: 'get',
        url: '/update_show_state',
        data: { state: 'remove', show_id: show_id },
        success: function(data){
          show.closest('.show').fadeOut();
          // $(this).removeClass('remove').addClass('add');
          // $(this).text('favorite');
        },
        error: function(data){
          $('.notice').text('There was a problem while trying to remove this show from your dashboard.').fadeIn();
        },
        dataType: 'text'
      });
    }
    return false;
  });


  $('.episode_number, .name, .air_date', '#episodes .episode').bind('click', function(){
    episode_url = $(this).find('.name a').attr('href')
    alert(episode_url);
  });


  $('#episodes .episode').hover(
    function(){ $(this).addClass('active'); },
    function(){ $(this).removeClass('active'); }
  );


  // Toggle season state
  $('.season input:checkbox').bind('click', function(){
    var checked = $(this).is(':checked');
    var message = "";

    // Set confirmation message
    if (checked) { message = "Are you sure you want to mark all episodes in this season as watched?"; }
    else { message = "Are you sure you want to mark all episodes in this season as unwatched?"; }

    // If user accepts confirmation, toggle episodes and set season
    if (confirm(message)) {
      $(this).closest('.season_episodes').find('.episode input:checkbox').attr('checked', checked);
      console.log('season checked: ' + checked);
      set_season_state($(this).closest('.season_episodes'), checked);
    } else {
      $(this).attr('checked', !checked);
    }
  });


  // Toggle episode state
  $('.episode input:checkbox').bind('click', function(){
    update_episode_state($(this));
    set_season_state($(this).closest('.season_episodes'));
  });

});




function initialize_seasons(){
  $('.season_episodes').each(function(i){
    set_season_state($(this));
  });
}


function season_status(season){
  episode_count = season.find('.episode').length;
  checked_count = season.find('.episode input:checked').length;
  return episode_count == checked_count;
}


function update_episode_state(episode){
  episode_id = episode.closest('.episode').attr('id').split('_')[1];
  episode_state = episode.is(':checked') ? 'add' : 'remove';
  $.get('/update_episode_state', { episode_id: episode_id, state: episode_state });
}


function set_season_state(season, state){
  console.log('set_season_state: ' + state);
  if (state != null) {
    update_season_state(season, state);
  } else {
    season.find('.season input:checkbox').attr('checked', season_status(season));
  }
}


function update_season_state(season, state){
  console.log('update_season_state: ' + state);
  season_number = season.find('.season').attr('id').split('_')[1];
  show_id = season.closest('#content').find('.show_name').attr('id').split('_')[1];
  $.get('/update_season_state', { show_id: show_id, season: season_number, state: state });
}