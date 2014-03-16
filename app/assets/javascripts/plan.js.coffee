jQuery ->
  behavior_selector('select-inspire-image').click (e) ->
    e.preventDefault()
    $('#plan_image_path').val("inspiring/#{$(@).data('index')}.jpg")

  behavior_selector('show-plan-tips').click (e) ->
    e.preventDefault()
    $('.plan-status .quote').slideDown('slow')

  behavior_selector('show-plan-success').click (e) ->
    e.preventDefault()
    $(@).parent('div').find('.plan-success-failure').slideDown()

  behavior_selector('show-plan-road-blocks').click (e) ->
    e.preventDefault()
    $(@).parent('div').find('.plan-road-blocks').slideDown()
