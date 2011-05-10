$.jQTouch({
  var jQT = $.jQTouch({
    icon: 'icon.png',
    startupScreen: 'startup.png',
    statusBar: 'black-translucent',
    fullScreen: true,
    fixedViewport: true,
    preloadImages: ['']
  });

  // Some sample Javascript functions:
  $(function(){
    function submitForm(){
      $el = $('#add form');

      if ($('#todo', $el).val().length > 1) {
        var itemid = $('#home ul li').length + 1;
        $('#home .incomplete').append($('<li><input type="checkbox" /> <span>' + $('#todo', $el).val() + '</span></li>'));
      }

      jQT.goBack();
      $el.get(0).reset();
      return false;
    }

    $('#add form').submit(submitForm);

    $('#add .whiteButton').click(submitForm);

    $('.complete li, .incomplete li').bind('swipe', function(){
       $(this).toggleClass('editingmode');
    });

    $('input[type="checkbox"]').live('change', function(){
      var $el = $(this);
      if ($el.attr('checked')) {
        $el.parent().prependTo('.complete');
      } else {
        $el.parent().appendTo('.incomplete');
      }
    });
  });
});