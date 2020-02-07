// Add styles to the form on focus
document.addEventListener("turbolinks:load", function () {
  $('.navbar-search-control, .home-search-control').focus(function () {
    $('.navbar-search, .home-search').addClass('is-focused');
  }).blur(function() {
    $('.navbar-search, .home-search').removeClass('is-focused');
  });
});