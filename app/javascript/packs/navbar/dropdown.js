// Dropdown container
document.addEventListener("turbolinks:load", function () {
  $('.navbar-dropdown-item').each(function () {
    var $dropdown = $(this);
    var $dropdownDrop = $dropdown.find('.navbar-dropdown');

    var offsetXIsset = $dropdown.data('offset-x') ? true : false;
    var offsetYIsset = $dropdown.data('offset-y') ? true : false;
    var offsetX = $dropdown ? parseInt($dropdown.data('offset-x') || 0, 10) : null;
    var offsetY = $dropdown ? parseInt($dropdown.data('offset-y') || 0, 10) : null;

    // Offset
    if (offsetXIsset) {
      $dropdownDrop.css({ 'margin-left': offsetX });
    }

    if (offsetYIsset) {
      $dropdownDrop.css({ 'margin-top': offsetY });
    }

    // Add open class on click
    $dropdown.click(function () {
      $(this).toggleClass('is-open');
    });

    // Outer click
    $(document).on("click", function (event) {
      if ($dropdown !== event.target && !$dropdown.has(event.target).length) {
        $dropdown.removeClass('is-open');
      }
    });
  });
});