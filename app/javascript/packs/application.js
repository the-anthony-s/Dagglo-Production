// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")

// Analytics
// import ahoy from 'ahoy.js';


import "packs/time/timezone";
import "packs/navbar/dropdown";
import "packs/forms/search";
import "packs/forms/main";
import "packs/mobile/hamburger";
import "packs/alerts/alert";

// Tracking
// import ahoy from "ahoy.js";



// Uppy File Uploader for Shrine gem
import {singleFileUpload, multipleFileUpload} from 'packs/forms/uppy';

document.addEventListener('turbolinks:load', () => {
  document.querySelectorAll('input[type=file]').forEach(fileInput => {
    if (fileInput.multiple) {
      multipleFileUpload(fileInput)
    } else {
      singleFileUpload(fileInput)
    }
  })
})
