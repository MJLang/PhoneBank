jQuery(function() {
  var menu = $("#slideMenu")
  if (!!menu.length > 0) {
    var slideout = new Slideout({
      'panel': document.getElementById('mainPanel'),
      'menu': document.getElementById('slideMenu'),
      'padding': 256,
      'tolerance': 70
    });

    $("#offcanvasButton").on('click', function(ev) {
      slideout.toggle();
    });
  }
});
