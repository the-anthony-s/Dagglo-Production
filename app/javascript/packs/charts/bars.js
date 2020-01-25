document.addEventListener("turbolinks:load", function () {
  $('.js-progressBar').each(function () {
    var dataWidth = $(this).data('value');
    $(this).css("width", dataWidth + "%");
  });
});