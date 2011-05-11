$(function(){
  $('.search_button').bind('click', function(){
    if ($('#search_box').is(':visible')){
      // TODO: We will eventually want this to simply slide back up if
      // no search is in progress, not reload the page
      $('#search_box').slideUp('fast');
    } else {
      $('#search_box').slideDown('fast');
      return false;
    }
  });
});