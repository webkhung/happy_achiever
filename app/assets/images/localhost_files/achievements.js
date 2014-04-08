(function() {
  jQuery(function() {
    var answer_entered;

    behavior_selector('achievement-toggle').click(function() {
      return $('.task-select').toggle($(this).data('type') === 'Task');
    });
    behavior_selector('state-change').click(function(e) {
      e.preventDefault();
      $('#state-button').html($(this).data('name') + " <span class='caret'></span>");
      $('input#achievement_state_id').val($(this).data('state-id'));
      $('#reason, #date, #privacy, #save-state').fadeIn().css('display', 'inline-block');
      return $('#privacy-tips').toggle($(this).data('state-id') > 0);
    });
    behavior_selector('extra-tips').click(function() {
      return $(this).focusout(function() {
        return $("#answer-tips-" + ($(this).data('answer'))).show();
      });
    });
    behavior_selector('show-answer-field').click(function() {
      $('#answer-' + $(this).data('answer') + ' .btn').removeClass('active');
      $(this).addClass('active');
      return $("#answer-field-" + ($(this).data('answer'))).show();
    });
    behavior_selector('answer-btn-clicked').click(function() {
      $("#answer-" + ($(this).data('answer')) + " .btn").removeClass('active');
      $(this).addClass('active');
      $("#answer-" + ($(this).data('answer')) + " .field").hide();
      $($(this).data('show')).show();
      $("#answer-" + ($(this).data('answer')) + " .question").hide();
      return $("html, body").animate({
        scrollTop: $(document).height()
      }, 'slow');
    });
    behavior_selector('answer-enter').keypress(function(e) {
      if (e.which === 13) {
        e.preventDefault();
        return answer_entered($(this));
      }
    });
    behavior_selector('answer-enter-btn').click(function() {
      return answer_entered($(this));
    });
    return answer_entered = function(obj) {
      $(obj.data('tips')).fadeIn();
      $(obj.data('show')).fadeIn(2000);
      return $("html, body").animate({
        scrollTop: $(document).height()
      }, 'slow');
    };
  });

}).call(this);
