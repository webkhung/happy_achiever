jQuery ->
  behavior_selector('achievement-toggle').click ->
    $('.task-select').toggle($(@).data('type') == 'Task')

  behavior_selector('state-change').click (e) ->
    e.preventDefault()

    $('#state-button').html($(@).data('name') +  " <span class='caret'></span>")
    $('input#achievement_state_id').val($(@).data('state-id'))

    if $(@).data('state-id') > 0
      $('#reason').fadeIn().css('display','inline-block')
    else
      $('#reason').hide()

  behavior_selector('extra-tips').click ->
    $(@).focusout ->
      $("#answer-tips-#{$(@).data('answer')}").show()

  behavior_selector('show-answer-field').click ->
    $('#answer-' + $(@).data('answer') + ' .btn').removeClass('active')
    $(@).addClass('active')
    $("#answer-field-#{$(@).data('answer')}").show()

  behavior_selector('answer-btn-clicked').click ->
    if $(@).data('answer') is 0
      $('.content-section').fadeIn('slow')
      $("#answer-0").hide()
      if $(@).data('target') is 'now'
        $('.now').show()
        $('.past').hide()
      else if $(@).data('target') is 'past'
        $('.now').hide()
        $('.past').show()
    else
      $("#answer-#{$(@).data('answer')} .btn").removeClass('active')
      $(@).addClass('active')

      $("#answer-#{$(@).data('answer')} .field").hide()
      $("#answer-#{$(@).data('target')}-#{$(@).data('answer')}").show()
      $("#answer-#{$(@).data('target')}-#{$(@).data('answer')}").show()

    $("#answer-#{$(@).data('answer')} .question").hide()
