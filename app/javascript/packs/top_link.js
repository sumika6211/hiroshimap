document.addEventListener('turbolinks:load', function() {
  $('.scroll-top a').on('click',function(event){
    $('body, html').animate({
      scrollTop:0
    }, 1000);
    event.preventDefault();
  });
});