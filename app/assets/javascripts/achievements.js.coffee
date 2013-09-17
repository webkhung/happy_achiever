jQuery ->
  behavior_selector('achievement-toggle').click ->
    $('.task-select').toggle($(@).data('type') == 'Task')

  behavior_selector('state-change').change ->
    if $(@).val() > 0
      $('#reason').fadeIn().css('display','inline-block')
    else
      $('#reason').hide()

  behavior_selector('extra-tips').click ->
    $(@).focusout ->
      $("#answer-tips-#{$(@).data('answer')}").show()
