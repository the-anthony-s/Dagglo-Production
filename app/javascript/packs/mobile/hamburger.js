// Mobile toggle menu
document.addEventListener("turbolinks:load", function () {
  var burger = document.querySelector('.navbar-burger, .sidebar-burger'),
      navbar = document.querySelector('.navbar, .sidebar'),
      menu = document.querySelector('.navbar-collapse, .sidebar-collapse'),
      body = document.querySelector('body');

  burger.onclick = function () {
    this.classList.toggle('is-open');
    navbar.classList.toggle('is-open');
    menu.classList.toggle('is-open');
    body.classList.toggle('no-scroll');
  }
});