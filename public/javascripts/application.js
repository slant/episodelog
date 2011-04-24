$(document).ready(function(){

  $('.show .add').bind('click', function(){
    show_id = $(this).closest('.show').attr('id');
    $.get('update_show_state', { state: 'add', show_id: show_id });
    return false;
  });

  $('.show .remove').bind('click', function(){
    show_id = $(this).closest('.show').attr('id');
    $.get('update_show_state', { state: 'remove', show_id: show_id });
    return false;
  });

});