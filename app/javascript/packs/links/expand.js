document.addEventListener("turbolinks:load", function () {
  $('.list-container-expand').on('click', function(e) {
    e.preventDefault();
    if ($(this).hasClass('is-active')) {
      $(this).removeClass('is-active');
      $(this).next()
      .stop()
      .slideUp(300);
    } else {
      $(this).addClass('is-active');
      $(this).next()
      .stop()
      .slideDown(300);
    }
  });
});
