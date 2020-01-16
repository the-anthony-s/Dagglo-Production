// Add styles to the form on focus
document.addEventListener("turbolinks:load", function () {
  $('.navbar-form-control').focus(function() {
    $('.navbar-form').addClass('is-focused');
  }).blur(function() {
    $('.navbar-form').removeClass('is-focused');
  });
});