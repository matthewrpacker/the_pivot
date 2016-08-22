$(document).ready(function(){
  var $events = $('.event');

  $('#event_filter_all').on('keyup', function(){
    var currentData = this.value;

    $events.each(function (index, event) {
      $event = $(event);
      if ( $event.data('all').toLowerCase().indexOf(currentData.toLowerCase()) !== -1 ) {
        $event.show();
      } else {
        $event.hide();
      }
    });
  });

  $('#yieldcontent').css('padding-top', $('#topnavbar').height() * 0.01);

  $(window).resize(function(){
    $('#yieldcontent').css('padding-top', $('#topnavbar').height() * 0.01);
  });

  $('#topnavbar').on('shown.bs.collapse', function () {
    $('#yieldcontent').css('padding-top', $('#topnavbar').height() * 0.01);
  });

  $('#topnavbar').on('hidden.bs.collapse', function () {
    $('#yieldcontent').css('padding-top', $('#topnavbar').height() * 0.01);
  });

});
