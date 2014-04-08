(function() {
  jQuery(function() {
    $('#chart-tabs a').click(function(e) {
      e.preventDefault();
      $(this).tab('show');
      return $(window).trigger('resize');
    });
    return $('#activities').jScrollPane();
  });

}).call(this);
