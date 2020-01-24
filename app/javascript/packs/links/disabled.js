document.addEventListener("turbolinks:load", function () {
  $('#disabledLink').click(function (e) {
    e.preventDefault();
  });
});