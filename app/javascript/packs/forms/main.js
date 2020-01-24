document.addEventListener("turbolinks:load", function () {

  // Auto-Resizable textarea
  $('textarea').each(function () {
    this.setAttribute('style', 'height:' + (this.scrollHeight) + 'px;overflow-y:hidden;resize:none;');
  }).on('input', function () {
    this.style.height = 'auto';
    this.style.height = (this.scrollHeight) + 'px';
  });


  // Drag and Drop field
  var $fileInput = $('.form-droparea, .d-form-droparea');
  var $droparea = $('.form-file-control, .d-form-file-control');

  $fileInput.on('dragenter focus click', function () {
    $droparea.addClass('is-active');
  });

  $fileInput.on('dragleave blur drop', function () {
    $droparea.removeClass('is-active');
  });

  $fileInput.on('change', function () {
    var filesCount = $(this)[0].files.length;
    var $textContainer = $(this).prev('.js-set-number');
    if (filesCount === 1) {
      $textContainer.text($(this).val().split('\\').pop());
    } else {
      $textContainer.text(filesCount + ' files selected');
    }
  });
});