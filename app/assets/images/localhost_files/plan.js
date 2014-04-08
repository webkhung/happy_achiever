(function() {
  jQuery(function() {
    behavior_selector('select-inspire-image').click(function(e) {
      e.preventDefault();
      return $('#plan_image_path').val("inspiring/" + ($(this).data('index')) + ".jpg");
    });
    behavior_selector('show-plan-tips').click(function(e) {
      e.preventDefault();
      return $('.plan-status .quote').toggle();
    });
    behavior_selector('show-plan-success').click(function(e) {
      e.preventDefault();
      $(this).parent('div').find('.plan-road-blocks').hide();
      return $(this).parent('div').find('.plan-success-failure').toggle();
    });
    return behavior_selector('show-plan-road-blocks').click(function(e) {
      e.preventDefault();
      $(this).parent('div').find('.plan-success-failure').hide();
      return $(this).parent('div').find('.plan-road-blocks').toggle();
    });
  });

}).call(this);
