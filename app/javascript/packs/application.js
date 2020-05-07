require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
require("chartkick")
require("chart.js")

import "packs/time/timezone";
import "packs/navbar/dropdown";
import "packs/forms/search";
import "packs/forms/main";
import "packs/mobile/hamburger";
import "packs/alerts/alert";
import "packs/carousel/glider-settings";
import "packs/images/lazyload";

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


  // Google Invisible reCaptcha
  document.getElementById('submit-HelloWorld').addEventListener('click', function (e) {
    // do some validation
    if (isValid) {
      // call reCAPTCHA check
      grecaptcha.execute();
    }
  });

  var submitInvisibleRecaptchaForm = function () {
    document.getElementById("invisible-recaptcha-form").submit();
  };
})
