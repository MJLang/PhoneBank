jQuery(function() {
  var panel = $("#slideMenu")
  if (!!panel) {
    var slideout = new Slideout({
      'panel': document.getElementById('mainPanel'),
      'menu': document.getElementById('slideMenu'),
      'padding': 256,
      'tolerance': 70
    });
  }
});
