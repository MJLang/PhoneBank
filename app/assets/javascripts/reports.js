jQuery(function() {
  $("#fileReport").on('click', function(event) {
    var userId = $(this).data('userid');
    var modal = $("#modal");
    $.ajax('/users/' + userId + '/outreach_reports/new').done(function(resp) {
      // console.log(resp);
      modal.html(resp);
      var reportModal = $("#reportModal");
      reportModal.foundation();
      reportModal.foundation('open');
    });
  });
});
