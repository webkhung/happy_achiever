(function() {
  window.behavior_selector = function(behavior_name) {
    return $("*[data-behavior~=" + behavior_name + "]");
  };

  jQuery(function() {
    $('#datepicker').datepicker({
      dateFormat: "yy-mm-dd"
    });
    $('.achievements').isotope({
      itemSelector: '.achievement'
    });
    $("*[rel~=tooltip], .tooltip").tooltip();
    behavior_selector('confirm-message').keyup(function(e) {
      if ($(this).val().toLowerCase() === $(this).data('message').toLowerCase()) {
        return $("#" + ($(this).data('unlock'))).slideDown();
      }
    });
    return behavior_selector('disable_after_click').click(function(e) {
      if ($(this).data('clicked')) {
        e.stopPropagation();
        return false;
      } else {
        return $(this).data('clicked', true);
      }
    });
  });

  $(window).load(function() {
    var $onLoadModal;

    if (window.onLoadModal && ($onLoadModal = $(window.onLoadModal)) && $onLoadModal.length) {
      return setTimeout(function() {
        if ($.support.touch) {
          $onLoadModal.removeClass('fade');
        }
        return $onLoadModal.modal();
      }, 500);
    }
  });

}).call(this);
