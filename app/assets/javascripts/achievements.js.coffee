jQuery ->
  behavior_selector('achievement-toggle').click ->
    $('.task-select').toggle($(@).data('type') == 'Task')

  behavior_selector('state-change').change ->
    $('#reason').toggle($(@).val() > 0)

  behavior_selector('extra-tips').click ->
    $(@).focusout ->
      $("#answer-tips-#{$(@).data('answer')}").show()
