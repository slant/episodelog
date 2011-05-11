$(function(){
  $('.search_button').toggle(
    function(){
      $('#search_box').slideDown('fast');
      return false;
    }, function(){
      $('#search_box').slideUp('fast');
      return false;
    }
  );
});