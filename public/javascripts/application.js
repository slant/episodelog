$(document).ready(function(){

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
      },
      error: function(data) {
        $('.notice').text('There was a problem while trying to remove this show from your dashboard.').fadeIn();
      }
    });
    //$('p#notice')
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
        },
        error: function(data){
          $('.notice').text('There was a problem while trying to remove this show from your dashboard.').fadeIn();
        },
        dataType: 'text'
      });
    }
    return false;
  });

  // Toggle episode state
  $('.episode input[type="checkbox"]').bind('click', function(){
    episode_id = $(this).closest('.episode').attr('id');
    state = $(this).is(':checked') ? 'add' : 'remove';
    $.get('/update_episode_state', { state: state, episode_id: episode_id });
  });

});