$(document).on('turbolinks:load', function(){

	$('.navbar-toggler').click(function(e){

    if ($(this).hasClass('sidebar-toggler')) {
      $('body').toggleClass('sidebar-nav');
      resizeBroadcast();
    }

    if ($(this).hasClass('aside-menu-toggler')) {
      $('body').toggleClass('aside-menu-hidden');
      resizeBroadcast();
    }

    if ($(this).hasClass('mobile-toggler')) {
      $('body').toggleClass('sidebar-nav mobile-open');
      resizeBroadcast();
    }
    e.preventDefault()

  });

  $('.sidebar-close').click(function(){
    $('body').toggleClass('sidebar-opened').parent().toggleClass('sidebar-opened');
  });

  function resizeBroadcast() {

    var timesRun = 0;
    var interval = setInterval(function(){
      timesRun += 1;
      if(timesRun === 5){
        clearInterval(interval);
      }
      window.dispatchEvent(new Event('resize'));
    }, 62.5);
  }

});