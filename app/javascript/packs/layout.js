document.addEventListener('turbolinks:load', function() {

    let tabs = $(".tab");
    $(".tab").on("click", function() {
      $(".active").removeClass("active");
      $(this).addClass("active");
      const index = tabs.index(this);
      $(".content").removeClass("show").eq(index).addClass("show");
    })

  $('.slider').slick({
    fade:true,
    autoplay: true,
    autoplaySpeed: 5000,
    speed:1500,
    infinite: true,
    slidesToShow: 1,
    slidesToScroll: 1,
    arrows: true,
    prevArrow: '<div class="slick-prev"></div>',
    nextArrow: '<div class="slick-next"></div>',
    dots: true,
      pauseOnFocus: false,
      pauseOnHover: false,
      pauseOnDotsHover: false,
  });
})