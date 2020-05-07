document.addEventListener("turbolinks:load", function () {

  // Auto-Resizable textarea
  $('textarea').each(function () {
    this.setAttribute('style', 'height:' + (this.scrollHeight) + 'px;overflow-y:hidden;resize:none;');
  }).on('input', function () {
    this.style.height = 'auto';
    this.style.height = (this.scrollHeight) + 'px';
  });


  // Phone field
  $("input[name='form[phone]']").on('keydown', function () {
    $(this).val($(this).val().replace(/^(\d{3})(\d{3})(\d)+$/g, '($1) $2-$3', 10));
  });


  // Remove spaces from input
  $('#noSpacesField').bind('input', function () {
    $(this).val(function (_, v) {
      return v.replace(/\s+/g, '');
    });
  });
});