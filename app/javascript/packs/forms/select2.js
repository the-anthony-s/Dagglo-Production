import $ from 'jquery'
import 'select2/dist/css/select2.css'
import 'select2'

document.addEventListener("turbolinks:load", function () {
  $('.js-states').select2();
  $('.js-categories').select2();
});