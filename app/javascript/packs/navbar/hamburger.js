// Mobile toggle menu
document.addEventListener("turbolinks:load", function () {
  var burger = document.querySelector('.navbar-burger'),
    menu = document.querySelector('.navbar-collapse'),
    body = document.querySelector('body');

  burger.onclick = function () {
    this.classList.toggle('is-open');
    menu.classList.toggle('is-open');
    body.classList.toggle('no-scorll');
  }
});