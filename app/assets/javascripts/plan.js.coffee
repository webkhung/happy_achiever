jQuery ->
  behavior_selector('next-step').click (e) ->
    e.preventDefault()

    if $(@).attr('disabled')
      return

    step = parseInt($(@).closest('.step').attr('id').substring('5'))

    $(@).closest('.step').slideUp ->
      $("#step-#{step+1}").slideDown()

  behavior_selector('previous-step').click (e) ->
    e.preventDefault()

    step = parseInt($(@).closest('.step').attr('id').substring('5'))

    $(@).closest('.step').slideUp ->
      $("#step-#{step-1}").slideDown()

  behavior_selector('select-inspire-image').click (e) ->
    e.preventDefault()
    $('#plan_image_path').val("inspiring/#{$(@).data('index')}.jpg")
