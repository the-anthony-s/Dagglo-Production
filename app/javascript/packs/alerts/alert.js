document.addEventListener("turbolinks:load", function () {
  $('.alert').each(function () {
    window.setTimeout(function () {
      $(".alert").fadeOut(100, function () {
        $(this).remove();
      });
    }, 10000);
  });

  $('.alert').click(function () {
    var target = $(this);
    target.closest('.alert').fadeOut();
  });
});
