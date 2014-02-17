jQuery ->
  behavior_selector('select-inspire-image').click (e) ->
    e.preventDefault()
    $('#plan_image_path').val("inspiring/#{$(@).data('index')}.jpg")
